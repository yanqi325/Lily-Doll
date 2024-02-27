
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_lily/Data/SqueezeTouchData.dart';
import 'package:project_lily/helperMethods/AuthHelper.dart';

import '../Data/Courses.dart';
import '../Data/Lessons.dart';

class DbHelper {
  //contains code to help get/recieve data from firestore

  //get userdata based on login user uid
  Future<DocumentSnapshot?> getUserDataFromFirestore(String uid) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access a specific document in a collection
      DocumentSnapshot documentSnapshot =
          await firestore.collection('usersExtended').doc(uid).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        print('Document ID: ${documentSnapshot.id}');
        print('Data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist');
      }

      return documentSnapshot;
    } catch (e) {
      print('Error retrieving data: $e');
      return null;
    }
  }

  //add squeeze touch data to usersExtended
  Future<void> addDocumentToDateSubcollection(SqueezeTouchData data) async {
    try {
      AuthHelper authHelper = new AuthHelper();
      String? userid = await authHelper.getCurrentUserId();

      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final squeezeTouchData = <String, String>{
        "SensorPartName": data.sensorPartName.toString(),
        "Pressure": data.pressure.toString(),
        "DateTime": data.timestamp.toString(),
        "IsTouch": data.isTouch.toString(),
        "IsSqueeze": data.isSqueeze.toString(),
      };

      // Reference to the 'usersExtended' collection
      CollectionReference usersExtendedCollectionRef =
          firestore.collection('usersExtended');

      // Reference to the 'SquuezeTouches' document within 'usersExtended'
      DocumentReference userDocumentRef =
          usersExtendedCollectionRef.doc(userid!);

      CollectionReference squeezeTouchesDocumentRef =
          userDocumentRef.collection('SquuezeTouches');

      var date = DateFormat('dd-MM-y').format(data.timestamp);
      // Reference to the 'date' subcollection within 'SquuezeTouches' document
      DocumentReference dateSubcollectionRef =
          squeezeTouchesDocumentRef.doc(date);

      // Add a document to the 'date' subcollection with a custom ID
      CollectionReference hourRef =
          dateSubcollectionRef.collection(data.hour.toString());

      // Add a 'total' collection to ease data retrieval
      CollectionReference totalItemRef =
          dateSubcollectionRef.collection("TotalItems");
      DocumentReference totalDocRef = totalItemRef.doc("total");

      //modify total doc ref
      DocumentSnapshot totalDocSnapshot = await totalItemRef.doc("total").get();
      if (totalDocSnapshot.exists) {
        num existingTotal =
            (totalDocSnapshot.data() as Map<String, dynamic>)["Total"];
        print("existingTotal is" + existingTotal.toString());
        existingTotal++;
        //alter it
        totalDocRef.set({"Total": existingTotal});
        print("Set Existing Total as: " + existingTotal.toString());
      } else {
        //create new document
        totalDocRef.set({"Total": 0});
      }

      await hourRef.add(squeezeTouchData);

      print('Document added successfully to the date subcollection');
    } catch (e) {
      print('Error adding document to the date subcollection: $e');
    }
  }

  //get SqueezeTouchdata for the past 24hours
  Future<List<SqueezeTouchData>> getDataFromAllDateSubcollections(
      String dateToSearch) async {
    try {
      AuthHelper authHelper = new AuthHelper();
      String? userid = await authHelper.getCurrentUserId();

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the 'usersExtended' collection
      CollectionReference usersExtendedCollectionRef =
          firestore.collection('usersExtended');

      // Reference to the 'SquuezeTouches' document within 'usersExtended'
      DocumentReference userDocumentRef =
          usersExtendedCollectionRef.doc(userid!);

      CollectionReference squeezeTouchesDocumentRef =
          userDocumentRef.collection('SquuezeTouches');

      // Reference to the 'date' subcollection within 'SquuezeTouches' document
      DocumentReference dateSubcollectionRef =
          squeezeTouchesDocumentRef.doc(dateToSearch);

      //iterate through hours 0 - 23 to get all daily squeezetouch records
      List<SqueezeTouchData> allData = [];

      for (int hour = 0; hour < 24; hour++) {
        //get coresponding hour collection
        CollectionReference hourSubcollectionRef =
            dateSubcollectionRef.collection(hour.toString());

        // Get all documents in the collection
        QuerySnapshot querySnapshot = await hourSubcollectionRef.get();
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((doc) {
            // Extract data from the document
            Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
            // SqueezeTouchData newData = SqueezeTouchData.fromMap(data);
            SqueezeTouchData newData = new SqueezeTouchData(
                data["SensorPartName"],
                double.parse(data["Pressure"]),
                DateTime.parse(data['DateTime']));

            allData.add(newData);
            // print(doc.data());
          });
        }
      }

      return allData;
    } catch (e) {
      print('Error retrieving data: $e');
      return [];
    }
  }

  //New update total method
  Future<void> incrementCounter(String date, int totalUpdate) async {
    try {

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

      // Reference to the 'date' subcollection within 'SquuezeTouches' document
      DocumentReference dateSubcollectionRef =
      squeezeTouchesDocumentRef.doc(date);

      // Add a 'total' collection to ease data retrieval
      CollectionReference totalItemRef =
      dateSubcollectionRef.collection("TotalItems");
      // Get reference to the "Total" document in the "TotalItems" collection
      DocumentReference totalRef = totalItemRef.doc('total');

      //check if exists
      if (!(await totalRef.get()).exists) {
        await totalRef.set({'Total': 0});
      }
      // Run a Firestore transaction to increment the counter
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Update the counter value in the document
        transaction.update(totalRef, {'Total': totalUpdate});
        print("Updated " + date + "with total: " +totalUpdate.toString());
      });

      print('Counter incremented successfully.');
    } catch (e) {
      print('Error incrementing counter: $e');
    }
  }

  // Method to write the Courses object to Firestore
  Future<void> addCourseToFirestore(Courses course) async {
    try {
      //add course object
      DocumentReference documentReference = FirebaseFirestore.instance.collection('courses').doc(course.courseTitle);
      await documentReference.set(course.toMap());
      print("Success in adding course to firestore");
    } catch (e) {
      print('Error adding course to Firestore: $e');
    }
  }

  // Method to write the lesson object to Firestore
  Future<void> addLessonToFirestore(Lessons lesson,String courseTitle) async {
    try {
      CollectionReference lessonsCollection = FirebaseFirestore.instance
          .collection('courses')
          .doc(courseTitle)
          .collection('lessons');
      DocumentReference lessonDocRef = lessonsCollection.doc(lesson.lessonTitle);
      await lessonDocRef.set(lesson.toMap());
      print("Success in adding lesson to firestore");
    } catch (e) {
      print('Error adding course to Firestore: $e');
    }
  }

  // //method to aread course data from firestore
  // static Stream<List<Courses>> getAllCoursesFromFirestore() {
  //   return FirebaseFirestore.instance.collection('courses').snapshots().map((snapshot) => snapshot.docs.map((doc) {
  //     return Courses.fromMap(doc.data());
  //   }).toList());
  // }

  //method to retrieve all courses
  Future<List<Courses>> getAllCoursesFromFirestore() async {
    try {
      // Reference to the "courses" collection
      CollectionReference coursesCollection = FirebaseFirestore.instance.collection('courses');

      // Get snapshot of documents in the "courses" collection
      QuerySnapshot querySnapshot = await coursesCollection.get();

      // Convert each document snapshot to a Course object
      List<Courses> coursesList = querySnapshot.docs.map((doc) {
        return Courses.fromMap(doc.data()! as Map <String,dynamic>);
      }).toList();

      return coursesList;
    } catch (e) {
      print('Error getting courses: $e');
      return []; // Return an empty list if there's an error
    }
    //get all lessons belonging to course

    //compile into list
    //return list
  }

}
