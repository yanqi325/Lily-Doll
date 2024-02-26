import 'package:flutter/cupertino.dart';

//make it local for now
enum CourseCategory {
  DailyHabits,
  Science,
  Maths
}

class Courses{
   String courseTitle;
   String courseDesc;
   CourseCategory category;
   String thumbnailUrl;
   int enrolledUserNum = 0;

   Courses(this.courseTitle,this.courseDesc,this.category,this.thumbnailUrl,this.enrolledUserNum) {
     //initialize class
   }

   // Method to convert class variables to a map
   Map<String, dynamic> toMap() {
     return {
       'courseTitle': courseTitle,
       'courseDesc': courseDesc,
       'category': category.toString().split('.').last,
       'thumbnailUrl': thumbnailUrl,
       'enrolledUserNum': enrolledUserNum,
     };
   }

   // Method to create a Courses object from a map
   static Courses fromMap(Map<String, dynamic> map) {
     return Courses(
       map['courseTitle'],
       map['courseDesc'],
       CourseCategory.values.firstWhere((category) => category.toString() == 'CourseCategory.${map['category']}'),
       map['thumbnailUrl'],
       map['enrolledUserNum'],
     );
   }

}
