import 'package:cloud_firestore/cloud_firestore.dart';

class SqueezeTouchData{
  //data model class for all squeeze and touch
  String sensorPartName;
  double pressure;
  DateTime timestamp;
  bool isSqueeze = false;
  bool isTouch = false;
  int hour =-1;
  static double touchThreshold = 50.0;

  SqueezeTouchData(this.sensorPartName, this.pressure, this.timestamp){
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

  // Convert SqueezeTouchData instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'sensorPartName': sensorPartName,
      'pressure': pressure,
      'timestamp': Timestamp.fromDate(timestamp),
      'isSqueeze': isSqueeze,
      'isTouch': isTouch
    };
  }

  // Create a SqueezeTouchData instance from a Map
  static SqueezeTouchData fromMap(Map<String, dynamic> map) {
    return SqueezeTouchData(
      map['sensorPartName'],
      map['pressure'],
      (map['timestamp'] as Timestamp).toDate()
    );
  }
}