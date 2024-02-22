import 'package:cloud_firestore/cloud_firestore.dart';

class SqueezeTouchData{
  //data model class for all squeeze and touch
  String sensorPartName;
  double pressure;
  DateTime timestamp;
  bool isSqueeze = false;
  bool isTouch = false;
  int hour;
  static double touchThreshold = 50.0;

  SqueezeTouchData(this.sensorPartName, this.pressure, this.timestamp,this.hour){
    determineType();
  }

  //set squeeze or touch
  void determineType(){
    if (pressure > touchThreshold){
      isSqueeze = true;
    }else{
      isTouch = true;
    }
  }
}