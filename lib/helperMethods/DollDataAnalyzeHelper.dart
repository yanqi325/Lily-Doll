import 'package:flutter/services.dart' show rootBundle;
import 'package:project_lily/Data/SqueezeTouchData.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';

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

  List<SqueezeTouchData> addToList(List<List<String>> dummy) {
    List<SqueezeTouchData> datalist =[];
    //add to list 1 by 1
    for (List<String> singleEntry in dummy) {

      if(singleEntry.isNotEmpty && singleEntry.length ==3){
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

    List<SqueezeTouchData> SqueezeTouchDataList=[];
    //decode doll data
    List<List<String>> data =await parseTextFile();

    //create list of squeeze touch objects
    SqueezeTouchDataList = await addToList(data);

    // print(SqueezeTouchDataList);

    //save objects into firebase
    DbHelper dbHelper = new DbHelper();
    SqueezeTouchDataList.forEach((element) {
      dbHelper.addDocumentToDateSubcollection(element);
    });

  }

  //get touch percentages in the past 24 hours
  Future<Map<String, double>> calculateTouchPercentages (String dateToSearch) async {
    //list sensors here
    int sensor1 = 0;
    int sensor2 =0;

    //key=sensorName, value=touchPercentage
    DbHelper dbHelper = new DbHelper();
    List<SqueezeTouchData>? data = await dbHelper.getDataFromAllDateSubcollections(dateToSearch);
    if(data != null){
      data.forEach((element) {
        if(element.isTouch){
          switch(element.sensorPartName){
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
    Map<String,double> touchPercentages = {
      "sensor1": sensor1Percent,
      "sensor2" :sensor2Percent
    };

    // print("Sensor1= " + sensor1.toString());
    // print("Sensor1= " + sensor2.toString());

    return touchPercentages;
  }

  //get squeeze percentages in the past 24 hours
  Future<Map<String, double>> calculateSqueezePercentages (String dateToSearch) async {
    //list quartiles here
    int firstQuartile = 0;
    int secondQuartile =0;
    int thirdQuartile = 0;
    int fourthQuartile = 0;

    //key=quartile of day, value=squeezePercentage
    DbHelper dbHelper = new DbHelper();
    List<SqueezeTouchData>? data = await dbHelper.getDataFromAllDateSubcollections(dateToSearch);
    if(data != null){
      data.forEach((element) {
        if(element.isSqueeze){
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
    int total = firstQuartile+ secondQuartile + thirdQuartile + fourthQuartile;
    double firstQuartilePercent = firstQuartile / total;
    double secondQuartilePercent = secondQuartile / total;
    double thirdQuartilePercent = thirdQuartile / total;
    double fourthQuartilePercent = fourthQuartile / total;

    //create map
    Map<String,double> squeezePercentages = {
      "firstQuartile": firstQuartilePercent,
      "secondQuartile" :secondQuartilePercent,
      "thirdQuartile" : thirdQuartilePercent,
      "fourthQuartile" : fourthQuartilePercent
    };

    print("1= " + firstQuartile.toString());
    print("2= " + secondQuartile.toString());
    print("3= " + thirdQuartile.toString());
    print("4= " + fourthQuartile.toString());

    return squeezePercentages;
  }
}