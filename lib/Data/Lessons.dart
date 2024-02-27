import 'package:flutter/cupertino.dart';

//make it local for now
enum LessonCategory {
  DailyHabits,
  Science,
  Maths
}

class Lessons{
  String lessonTitle;
  String lessonDesc;
  LessonCategory category;
  String thumbnailUrl;

  Lessons(this.lessonTitle,this.lessonDesc,this.category,this.thumbnailUrl) {
    //initialize class
  }

  // Method to convert class variables to a map
  Map<String, dynamic> toMap() {
    return {
      'courseTitle': lessonTitle,
      'courseDesc': lessonDesc,
      'category': category.toString().split('.').last,
      'videoUrl': thumbnailUrl,
    };
  }

  // Method to create a Courses object from a map
  static Lessons fromMap(Map<String, dynamic> map) {
    return Lessons(
      map['courseTitle'],
      map['courseDesc'],
      LessonCategory.values.firstWhere((category) => category.toString() == 'CourseCategory.${map['category']}'),
      map['videoUrl'],
    );
  }

}