import 'package:flutter/cupertino.dart';

//make it local for now
enum LessonCategory {
  DailyHabits,
  Science,
  Maths
}

class Lessons{
  // int lessonNo;
  String lessonTitle;
  String lessonDesc;
  LessonCategory category;
  String thumbnailUrl;
  bool? isLocked;

  Lessons(this.lessonTitle,this.lessonDesc,this.category,this.thumbnailUrl) {
    //initialize class
  }

  // Method to convert class variables to a map
  Map<String, dynamic> toMap() {
    return {
      'lessonTitle': lessonTitle,
      'lessonDesc': lessonDesc,
      'category': category.toString().split('.').last,
      'videoUrl': thumbnailUrl,
      // "isLocked" : isLocked
    };
  }

  // Method to create a Courses object from a map
  static Lessons fromMap(Map<String, dynamic> map) {
    return Lessons(
      map['lessonTitle'],
      map['lessonDesc'],
      LessonCategory.values.firstWhere((category) => category.toString() == 'LessonCategory.${map['category']}'),
      map['videoUrl']
        // (map["isLocked"] as bool)
    );
  }

}