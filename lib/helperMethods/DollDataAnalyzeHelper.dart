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

  //TODO: fix this
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

}