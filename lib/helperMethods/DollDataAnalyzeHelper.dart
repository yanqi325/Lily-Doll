import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:project_lily/Data/SqueezeTouchData.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';

import 'AuthHelper.dart';

class DollDataAnalyzeHelper {
  //contains methods on analyzing and sorting data from the doll

  Future<List<List<String>>> parseTextFile() async {
    // Load the text file from assets
    //TODO: Change to get data from bluetooth
    String textContent = await rootBundle.loadString('assets/test.txt');

    // Split the text content into lines
    List<String> lines = textContent.split('\n');

    // Parse each line and split by comma
    List<List<String>> textData = lines.map((line) => line.split(',')).toList();

    return textData;
  }

  //TODO: Test
  Future<List<List<String>>> parseTextFileBLE(List<String> lines) async {
    List<List<String>> textData = lines.map((line) => line.split(',')).toList();

    return textData;
  }

  void decodeDollDataBLE(List<String> lines) async {
    List<SqueezeTouchData> SqueezeTouchDataList = [];
    //decode doll data
    List<List<String>> data = await parseTextFileBLE(lines);

    //create list of squeeze touch objects
    SqueezeTouchDataList = await addToList(data);

    //create variable to store how many additions to each date
    Map<String,int> totalAdditions = new Map<String,int>();

    //save objects into firebase
    DbHelper dbHelper = new DbHelper();
    SqueezeTouchDataList.forEach((element) async {

      dbHelper.addDocumentToDateSubcollection(element);
      var date = DateFormat('dd-MM-y').format(element.timestamp);
      if (totalAdditions.containsKey(date)){
        //if contains, then add one to the value
        int totalFromFirebase = totalAdditions[date]!;
        totalFromFirebase++;
        totalAdditions[date] = totalFromFirebase;
      }else{
        //create new key
        totalAdditions[date] = 1;
      }
      print(totalAdditions);

    });
    //last resort method to add total at the end
    totalAdditions.forEach((key, value) {
      dbHelper.incrementCounter(key, value);
    });
  }

  List<SqueezeTouchData> addToList(List<List<String>> dummy) {
    List<SqueezeTouchData> datalist = [];
    //add to list 1 by 1
    for (List<String> singleEntry in dummy) {
      if (singleEntry.isNotEmpty && singleEntry.length == 3) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(singleEntry[2]) * 1000);
        var hour = date.hour;
        SqueezeTouchData st = new SqueezeTouchData(
            singleEntry[0], double.parse(singleEntry[1]), date);
        st.hour = hour;
        datalist.add(st);
      }
    }
    return datalist;
  }

  //get data from bluetooth, and transform data into object, and upload to firebase
  void decodeDollData() async {
    List<SqueezeTouchData> SqueezeTouchDataList = [];
    //decode doll data
    List<List<String>> data = await parseTextFile();

    //create list of squeeze touch objects
    SqueezeTouchDataList = await addToList(data);

    //create variable to store how many additions to each date
    Map<String,int> totalAdditions = new Map<String,int>();

    //save objects into firebase
    DbHelper dbHelper = new DbHelper();
    SqueezeTouchDataList.forEach((element) async {

      dbHelper.addDocumentToDateSubcollection(element);
      var date = DateFormat('dd-MM-y').format(element.timestamp);
      if (totalAdditions.containsKey(date)){
        //if contains, then add one to the value
        int totalFromFirebase = totalAdditions[date]!;
        totalFromFirebase++;
        totalAdditions[date] = totalFromFirebase;
      }else{
        //create new key
        totalAdditions[date] = 1;
      }
      print(totalAdditions);

    });
    //last resort method to add total at the end
    totalAdditions.forEach((key, value) {
      dbHelper.incrementCounter(key, value);
    });
  }

  //get touch percentages in the past 24 hours
  Future<Map<String, double>> calculateTouchPercentages(
      String dateToSearch) async {
    //list sensors here
    int sensor1 = 0;
    int sensor2 = 0;

    //key=sensorName, value=touchPercentage
    DbHelper dbHelper = new DbHelper();
    List<SqueezeTouchData>? data =
        await dbHelper.getDataFromAllDateSubcollections(dateToSearch);
    if (data != null) {
      data.forEach((element) {
        if (element.isTouch) {
          switch (element.sensorPartName) {
            case "sensor1":
              sensor1++;
              break;
            case "sensor2":
              sensor2++;
              break;
          }
        }
      });
    }
    //calculate percentage
    int total = sensor1 + sensor2;
    double sensor1Percent = sensor1 / total;
    double sensor2Percent = sensor2 / total;

    //create map
    Map<String, double> touchPercentages = {
      "sensor1": sensor1Percent,
      "sensor2": sensor2Percent
    };

    // print("Sensor1= " + sensor1.toString());
    // print("Sensor1= " + sensor2.toString());

    return touchPercentages;
  }

  //get squeeze percentages in the past 24 hours
  Future<Map<String, double>> calculateSqueezePercentages(
      String dateToSearch) async {
    //list quartiles here
    int firstQuartile = 0;
    int secondQuartile = 0;
    int thirdQuartile = 0;
    int fourthQuartile = 0;

    //key=quartile of day, value=squeezePercentage
    DbHelper dbHelper = new DbHelper();
    List<SqueezeTouchData>? data =
        await dbHelper.getDataFromAllDateSubcollections(dateToSearch);
    if (data != null) {
      data.forEach((element) {
        if (element.isSqueeze) {
          element.hour = element.timestamp.hour;
          print(element.timestamp);
          print(element.timestamp.hour);
          // Determine quartile and add element accordingly
          if (element.hour >= 1 && element.hour <= 6) {
            firstQuartile++;
          } else if (element.hour >= 7 && element.hour <= 12) {
            secondQuartile++;
          } else if (element.hour >= 13 && element.hour <= 18) {
            thirdQuartile++;
          } else if (element.hour >= 19 && element.hour <= 24) {
            fourthQuartile++;
          }
        }
        // print(element.hour);
      });
    }
    //calculate percentage
    int total = firstQuartile + secondQuartile + thirdQuartile + fourthQuartile;
    double firstQuartilePercent = firstQuartile / total;
    double secondQuartilePercent = secondQuartile / total;
    double thirdQuartilePercent = thirdQuartile / total;
    double fourthQuartilePercent = fourthQuartile / total;

    //create map
    Map<String, double> squeezePercentages = {
      "firstQuartile": firstQuartilePercent,
      "secondQuartile": secondQuartilePercent,
      "thirdQuartile": thirdQuartilePercent,
      "fourthQuartile": fourthQuartilePercent
    };
    //
    // print("1= " + firstQuartile.toString());
    // print("2= " + secondQuartile.toString());
    // print("3= " + thirdQuartile.toString());
    // print("4= " + fourthQuartile.toString());

    return squeezePercentages;
  }

  //get total SqueezeTouchData for the current week
  Future<Map<int, int>> getDataProcessedForThisWeek(String currentDate) async {
    DbHelper dbHelper = new DbHelper();
    //get range of dates to find
    Map<int, String> allDatesInWeek = getDatesInWeek(currentDate);

    //define Map to hold all data
    Map<int, int> allWeekDataFinal = new Map<int, int>();

    //call getDataFromAllDateSubCollections to get data for dates
    for(int i =1; i <8;i++){
      allWeekDataFinal[i] = await getTotalSqueezePerday(allDatesInWeek[i]!);
      print("this is data for day: " + i.toString() + " : " + allWeekDataFinal[i].toString());
    }
    return allWeekDataFinal;
  }

  //get all days in a week
  //Return format (Ex. "monday" -> "1-1-2023")
  Map<int, String> getDatesInWeek(String dateInString) {
    //format
    DateFormat format = new DateFormat("dd-MM-yyyy");
    DateTime date = format.parse(dateInString);

    // Get the starting date of the week (Sunday)
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Initialize a list to store the dates
    Map<int, String> allDatesInWeekString = new Map<int, String>();

    // Loop to add each date in the week to the list
    for (int i = 0; i < 7; i++) {
      String date = format.format(startOfWeek.add(Duration(days: i)));
      allDatesInWeekString[i+1] = date;
      print("The date included are : " + date.toString());
    }

    return allDatesInWeekString;
  }

  Future<int> getTotalSqueezePerday(String data) async {

    int totalSqueeze = 0;
    AuthHelper authHelper = new AuthHelper();
    String? userid = await authHelper.getCurrentUserId();

    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Reference to the 'usersExtended' collection
    CollectionReference usersExtendedCollectionRef =
    firestore.collection('usersExtended');

    // Reference to the 'SquuezeTouches' document within 'usersExtended'
    DocumentReference userDocumentRef = usersExtendedCollectionRef.doc(userid!);

    CollectionReference squeezeTouchesDocumentRef =
    userDocumentRef.collection('SquuezeTouches');

    // var date = DateFormat('dd-MM-y').format(data.timestamp);
    // Reference to the 'date' subcollection within 'SquuezeTouches' document
    DocumentReference dateSubcollectionRef =
    squeezeTouchesDocumentRef.doc(data);

    // Add a 'total' collection to ease data retrieval
    CollectionReference totalItemRef =
    dateSubcollectionRef.collection("TotalItems");
    DocumentReference totalDocRef = totalItemRef.doc("total");

    DocumentSnapshot totalDocSnapshot = await totalItemRef.doc("total").get();
    if (totalDocSnapshot.exists) {
      totalSqueeze =
      (totalDocSnapshot.data() as Map<String, dynamic>)["Total"];
    } else {
    }
    return totalSqueeze;
  }
}
