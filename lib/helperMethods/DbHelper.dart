import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      DocumentReference userDocumentRef =
          usersExtendedCollectionRef.doc(userid!);

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
        print("Updated " + date + "with total: " + totalUpdate.toString());
      });

      print('Counter incremented successfully.');
    } catch (e) {
      print('Error incrementing counter: $e');
    }
  }

  // Method to write the Courses object to Firestore
  Future<void> addCourseToFirestore(Courses course) async {
    try {
      AuthHelper authHelper = new AuthHelper();
      String? userid = await authHelper.getCurrentUserId();
      //add course object
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("usersExtended")
          .doc(userid)
          .collection('courses')
          .doc(course.courseTitle);
      await documentReference.set(course.toMap());
      print("Success in adding course to firestore");
    } catch (e) {
      print('Error adding course to Firestore: $e');
    }
  }

  // Method to write the lesson object to Firestore
  Future<void> addLessonToFirestore(Lessons lesson, String courseTitle) async {
    AuthHelper authHelper = new AuthHelper();
    String? userid = await authHelper.getCurrentUserId();
    try {
      CollectionReference lessonsCollection = FirebaseFirestore.instance
          .collection("usersExtended")
          .doc(userid)
          .collection('courses')
          .doc(courseTitle)
          .collection('lessons');
      DocumentReference lessonDocRef =
          lessonsCollection.doc(lesson.lessonTitle);
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
    AuthHelper authHelper = new AuthHelper();
    String? userid = await authHelper.getCurrentUserId();
    try {
      // Reference to the "courses" collection
      CollectionReference coursesCollection = FirebaseFirestore.instance
          .collection("usersExtended")
          .doc(userid)
          .collection('courses');

      // Get snapshot of documents in the "courses" collection
      QuerySnapshot querySnapshot = await coursesCollection.get();

      // Convert each document snapshot to a Course object
      List<Courses> coursesList = querySnapshot.docs.map((doc) {
        return Courses.fromMap(doc.data()! as Map<String, dynamic>);
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

  Future<List<Lessons>> getALlLessonsOfCourse(String courseName) async {
    AuthHelper authHelper = new AuthHelper();
    String? userid = await authHelper.getCurrentUserId();
    try {
      // Reference to the "lessons" subcollection inside the specified "course" document
      CollectionReference lessonsCollection = FirebaseFirestore.instance
          .collection("usersExtended")
          .doc(userid)
          .collection('courses')
          .doc(courseName)
          .collection('lessons');
      print("start");

      // Get snapshot of documents in the "lessons" subcollection
      QuerySnapshot querySnapshot = await lessonsCollection.get();

      print(querySnapshot.size);
      List<Lessons> lessonsList = [];
      querySnapshot.docs.forEach((element) {
        print("Started");
        print(element.data()! as Map<String, dynamic>);
        Lessons lesson =
            Lessons.fromMap(element.data()! as Map<String, dynamic>);
        lessonsList.add(lesson);
        print("Added " + lesson.lessonTitle);
      });
      // Convert each document snapshot to a Lesson object
      //  = querySnapshot.docs.map((doc) {
      //   return Lessons.fromMap(doc.data()! as Map<String,dynamic>);
      // }).toList();

      return lessonsList;
    } catch (e) {
      print('Error getting lessons: $e');
      return []; // Return an empty list if there's an error
    }
  }

  Future<String> uploadImage() async {
    String downloadURL = "";
    // Open the file picker
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      PlatformFile file = result.files.first;

      // Upload the selected image file to Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
      final finalFile = File(file.path!);

      final uploadTask = storageRef.putFile(finalFile);
      final snapshot = await uploadTask.whenComplete(() => {});

      final downloadURL = await snapshot.ref.getDownloadURL();
      print('Download URL: $downloadURL');
      print('Image uploaded to Firebase Storage');

      return downloadURL;
    } else {
      // User canceled the file picking
      print('User canceled the file picking');
      return downloadURL;
    }
  }

  //Get all user names in firebase and return user id that matches user name
  Future<String> getUsernamesFromUsersExtended(String userName) async {
    String userid = '';
    try {
      // Get reference to the 'usersExtended' collection
      CollectionReference usersExtendedRef =
          FirebaseFirestore.instance.collection('usersExtended');

      // Get all documents in the 'usersExtended' collection
      QuerySnapshot usersExtendedSnapshot = await usersExtendedRef.get();

      // Iterate through each document
      usersExtendedSnapshot.docs.forEach((DocumentSnapshot doc) {
        // Get the 'username' field from each document
        String? username = doc['Username'];
        if (username != "" && username!.toLowerCase() == userName) {
          userid = doc.id;
        }
        // print(username);
      });
    } catch (error) {
      // Handle any errors
      print('Error retrieving usernames : $error');
    }

    return userid;
  }


//Add user id into 'enrolledUsers' collection inside 'usersExtended' -> 'courses'
  Future<void> addUserToEnrolledUsers(String educatorId, String courseTitle,String userId) async {
    try {
      // Reference to the 'enrolledUsers' collection within the 'courses' subcollection
      CollectionReference enrolledUsersRef = FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(educatorId)
          .collection('courses')
          .doc(courseTitle)
          .collection('enrolledUsers');

      // Add the user document to the 'enrolledUsers' collection
      await enrolledUsersRef.doc(userId).set({
        "progress": 0.toString()
      });

      print('User $userId added to enrolledUsers collection in course $courseTitle');
    } catch (error) {
      // Handle any errors
      print('Error adding user to enrolledUsers collection: $error');
    }
  }

//Add coursedetails into user account type inside 'usersExtended' -> 'enrolledCourses'
  Future<void> addUserToEnrolledCourses(String userId, String courseTitle) async {
    try {
      // Reference to the 'enrolledCourses' collection within the 'usersExtended' collection
      CollectionReference enrolledCoursesRef = FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(userId)
          .collection('enrolledCourses');


      // Add the course document to the 'enrolledCourses' collection
      await enrolledCoursesRef.doc(courseTitle).set({"progress": 0.toString()});


      print('Course $courseTitle added to enrolledCourses collection for user $userId');
    } catch (error) {
      // Handle any errors
      print('Error adding course to enrolledCourses collection: $error');
    }
  }

//Return course details based on what is inside 'usersExtended' -> 'enrolledCourses', based on educator id

//Add progress to course details based on user
}
