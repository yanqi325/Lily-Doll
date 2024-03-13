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

  //get specific course document based on educator id
  Future<Courses?> getCourseDocument(
      String educatorId, String courseTitle) async {
    try {
      // Reference to the document in the 'courses' subcollection
      DocumentReference courseDocRef = FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(educatorId)
          .collection('courses')
          .doc(courseTitle);

      // Get the document snapshot
      DocumentSnapshot courseSnapshot = await courseDocRef.get();

      print("RUN");
      if (courseSnapshot.exists) {
        // print("sxists");
        // print((courseSnapshot.data() as Map<String,dynamic>));
        // Convert the document snapshot to a Course object
        Courses course =
            Courses.fromMap((courseSnapshot.data() as Map<String, dynamic>));
        // print(course.courseTitle);
        // print(course.courseDesc);
        return course;
      } else {
        print('Course document with ID $courseTitle does not exist.');
        return null;
      }
    } catch (error) {
      // Handle any errors
      print('Error retrieving course document: $error');
      return null; // Return null in case of error
    }
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

      List<Lessons> lessonsList = [];
      querySnapshot.docs.forEach((element) {
        Lessons lesson =
            Lessons.fromMap(element.data()! as Map<String, dynamic>);
        lessonsList.add(lesson);
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
  Future<void> addUserToEnrolledUsers(
      String educatorId, String courseTitle, String userId) async {
    try {
      String userName = '';
      // Reference to the 'enrolledUsers' collection within the 'courses' subcollection
      CollectionReference enrolledUsersRef = FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(educatorId)
          .collection('courses')
          .doc(courseTitle)
          .collection('enrolledUsers');

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(userId)
          .get();

      if (documentSnapshot.exists) {
        userName =
            (documentSnapshot.data() as Map<String, dynamic>)['Username'];
      }

      // Add the user document to the 'enrolledUsers' collection
      await enrolledUsersRef
          .doc(userId)
          .set({"progress": 0.toString(), "Username": userName});

      print(
          'User $userId added to enrolledUsers collection in course $courseTitle');
    } catch (error) {
      // Handle any errors
      print('Error adding user to enrolledUsers collection: $error');
    }
  }

//Add coursedetails into user account type inside 'usersExtended' -> 'enrolledCourses'
  Future<void> addUserToEnrolledCourses(
      String userId, String courseTitle, String educatorId) async {
    try {
      // Reference to the 'enrolledCourses' collection within the 'usersExtended' collection
      CollectionReference enrolledCoursesRef = FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(userId)
          .collection('enrolledCourses');

      // Add the course document to the 'enrolledCourses' collection
      await enrolledCoursesRef
          .doc(courseTitle)
          .set({"progress": 0.toString(), "educatorId": educatorId});

      print(
          'Course $courseTitle added to enrolledCourses collection for user $userId');
    } catch (error) {
      // Handle any errors
      print('Error adding course to enrolledCourses collection: $error');
    }
  }

//Return course details based on what is inside 'usersExtended' -> 'enrolledCourses', based on educator id
//Get all enrolledCourses Name
  Future<List<Courses>> getEnrolledCourses() async {
    AuthHelper authHelper = new AuthHelper();
    String? userId = await authHelper.getCurrentUserId();
    List<Courses> courses = [];
    try {
      // Reference to the 'enrolledCourses' collection within the 'usersExtended' collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(userId)
          .collection('enrolledCourses')
          .get();

      // Extract document IDs from the query snapshot
      for (DocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> DocData = <String, dynamic>{
          "educatorId": doc["educatorId"],
          "progress": doc["progress"]
        };

        String educatorId = DocData["educatorId"];

        //search by course name
        //create courses method from prev returned data
        Courses? course = await getCourseDocument(educatorId, doc.id);
        if (course != null) {
          String progress = DocData["progress"];
          course.progress = double.parse(progress);
          courses.add(course);
        }
      }

      return courses;
    } catch (error) {
      // Handle any errors
      print('Error retrieving enrolled course IDs: $error');
      return []; // Return an empty list in case of error
    }
  }

//Get all users for specific course
  Future<List<Map<String, dynamic>>> getAllEnrolledUsers(
      String educatorId, String courseTitle) async {
    //manual delay to not show too fast
    await Future.delayed(Duration(seconds: 1));
    try {
      // Reference to the 'enrolledUsers' subcollection within 'courses' collection under 'usersExtended'
      CollectionReference enrolledUsersRef = FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(educatorId) // Replace 'your_user_id' with the actual user ID
          .collection('courses')
          .doc(courseTitle) // Replace 'course_id' with the actual course ID
          .collection('enrolledUsers');

      // Get all documents in the 'enrolledUsers' subcollection
      QuerySnapshot querySnapshot = await enrolledUsersRef.get();

      // Map each document snapshot to a map
      List<Map<String, dynamic>> enrolledUsers = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Return the list of maps
      print(enrolledUsers);
      return enrolledUsers;
    } catch (error) {
      // Handle any errors
      print('Error retrieving enrolled users: $error');
      return []; // Return an empty list in case of error
    }
  }

  //get lesson details at user POV
  Future<List<Lessons>> getLessonsFromCourseUser(String courseName) async {
    //get educator id from course USER POV
    //get all isLocked param for all lessons from uesr POV
    //get details of lessons from educator POV
    List<Lessons> allLessons = [];

    AuthHelper authHelper = new AuthHelper();
    String? userId = await authHelper.getCurrentUserId();
    //get educator ID first
    try {
      // Reference to the 'enrolledCourses' collection within the 'usersExtended' collection
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('usersExtended')
              .doc(userId)
              .collection('enrolledCourses')
              .doc(courseName)
          // .collection("lessons")
              .get();



      String educatorId = querySnapshot["educatorId"];

      // Reference to the "lessons" subcollection inside the specified "course" document
      CollectionReference lessonsCollection = FirebaseFirestore.instance
          .collection("usersExtended")
          .doc(educatorId)
          .collection('courses')
          .doc(courseName)
          .collection('lessons');
      print("start");

      // Get snapshot of documents in the "lessons" subcollection
      QuerySnapshot querySnapshot1 = await lessonsCollection.get();

      print(querySnapshot1.size);
      List<Lessons> lessonsList = [];
      querySnapshot1.docs.forEach((element) {
        print(element.data()! as Map<String, dynamic>);
        Lessons lesson =
            Lessons.fromMap(element.data()! as Map<String, dynamic>);
        lessonsList.add(lesson);
      });


      // Convert each document snapshot to a Lesson object
      //  = querySnapshot.docs.map((doc) {
      //   return Lessons.fromMap(doc.data()! as Map<String,dynamic>);
      // }).toList();


      return lessonsList;
    } catch (error) {
      return [];
    }
    return allLessons;
  }

  //get all users that have not been enrolled in this course
  Future<List<Map<String, dynamic>>> getAllUnenrolledUsers(
      String courseTitle) async {
    AuthHelper authHelper = new AuthHelper();
    String? userid = await authHelper.getCurrentUserId();
    List<Map<String, dynamic>> usersList = [];

    //get all users from educator "usersExtended" -> "courses" -> "enrolled Users [2]
    List<Map<String, dynamic>> excludeList =
        await getAllEnrolledUsers(userid!, courseTitle);
    //get all users from "usersExtended" [1]

    print("Excluded list includes: ");
    for (Map<String, dynamic> e in excludeList) {
      print(e['Username']);
    }
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('usersExtended').get();

      print("userList includes: ");
      querySnapshot.docs.forEach((doc) {
        if (doc.exists && doc.data() != null) {
          Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
          print(docData["Username"]);
          usersList.add(docData);
        }
      });
      for (Map<String, dynamic> e in excludeList) {
        usersList.removeWhere((item) => item["Username"] == e["Username"]);
        print("Removed" + e["Username"]);
      }
    } catch (error) {
      print('Error fetching usernames: $error');
    }
    return usersList;
  }

  //get all users from 'usersExtended'

  Future<List<String>> getAllUsernames() async {
    List<String> usernames = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('usersExtended').get();

      querySnapshot.docs.forEach((doc) {
        if (doc.exists && doc.data() != null) {
          dynamic username = (doc.data()! as Map<String, dynamic>)['Username'];
          if (username != null && username is String) {
            usernames.add(username);
          }
        }
      });
    } catch (error) {
      print('Error fetching usernames: $error');
    }

    return usernames;
  }

  Future<List<Map<String, dynamic>>> getEnrolledCoursesProgress(
      String userId) async {
    try {
      // Reference to the 'enrolledCourses' collection within the 'usersExtended' collection
      CollectionReference<Map<String, dynamic>> enrolledCoursesRef =
          FirebaseFirestore.instance
              .collection('usersExtended')
              .doc(userId)
              .collection('enrolledCourses');

      // Get the documents from the 'enrolledCourses' collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await enrolledCoursesRef.get();

      List<Map<String, dynamic>> userProgressList = [];

      // Iterate through each document in the collection
      querySnapshot.docs.forEach((doc) {
        // Get the document ID
        String docId = doc.id;

        // Create a Map to store the document ID and progress value
        Map<String, dynamic> progressMap = {
          "courseTitle": docId,
          "progress": doc['progress']
        };

        userProgressList.add(progressMap);
      });
      for (Map<String, dynamic> e in userProgressList) {
        print(e['courseTitle']);
        print(e["progress"]);
      }
      return userProgressList;
    } catch (error) {
      // Handle any errors
      print('Error fetching enrolled courses progress: $error');
      return []; // Return an empty map in case of error
    }
  }

  Future<String> getVideoIdFromLesson() async {
    return 'dQw4w9WgXcQ';
  }

  Future<String> getVideoIdFromLessonUser(String lessonTitle, String courseTitle) async {
    List<Lessons> lessonList = await getLessonsFromCourseUser(courseTitle);
    String videoId='';
    for (Lessons l in lessonList){
      if (l.lessonTitle == lessonTitle){
        videoId = l.thumbnailUrl;
      }
    }
    return videoId;
  }

  Future<String> getVideoIdFromLessonEducator(String lessonTitle, String courseTitle) async {
    AuthHelper authHelper = new AuthHelper();
    String? userId = await authHelper.getCurrentUserId();
    String videoId='';
    // Reference to the "lessons" subcollection inside the specified "course" document
    CollectionReference lessonsCollection = FirebaseFirestore.instance
        .collection("usersExtended")
        .doc(userId)
        .collection('courses')
        .doc(courseTitle)
        .collection('lessons');

    // Get snapshot of documents in the "lessons" subcollection
    QuerySnapshot querySnapshot1 = await lessonsCollection.get();

    querySnapshot1.docs.forEach((element) {
      print(element.data()! as Map<String, dynamic>);
      Lessons lesson =
      Lessons.fromMap(element.data()! as Map<String, dynamic>);
      if(lesson.lessonTitle == lessonTitle){
        videoId = lesson.thumbnailUrl;
      }
    });

    return videoId;
  }

  //for educator POV to change lesson lock status
  Future<void> updateLessonLockStatus(String courseId, String lessonId, bool isLocked) async {
    try {
      AuthHelper authHelper = new AuthHelper();
      String? userId = await authHelper.getCurrentUserId();
      // Reference to the specific document in Firestore
      DocumentReference lessonRef = FirebaseFirestore.instance
          .collection('usersExtended') // Collection
          .doc(userId) // Document ID
          .collection('courses') // Subcollection
          .doc(courseId) // Document ID
          .collection('lessons') // Subcollection
          .doc(lessonId); // Document ID

      // Update the isLocked field
      await lessonRef.update({
        'isLocked': isLocked,
      });

      print('Lesson lock status updated successfully');
    } catch (e) {
      print('Error updating lesson lock status: $e');
      // Handle any errors here
    }
  }


  //call this method when user is added to course, for ALL lessons
  Future<void> addFieldsToLessonDocumentUser(String userId, String courseId, String educatorId, bool isUnlocked) async {
    try {
      // List<Lessons> lessonList = await getLessonsFromCourseUser(courseId);
      CollectionReference lessonsCollection = FirebaseFirestore.instance
          .collection("usersExtended")
          .doc(educatorId)
          .collection('courses')
          .doc(courseId)
          .collection('lessons');
      print("start");


      // Get snapshot of documents in the "lessons" subcollection
      QuerySnapshot querySnapshot1 = await lessonsCollection.get();

      print(querySnapshot1.size);
      List<Lessons> lessonsList = [];
      querySnapshot1.docs.forEach((element) {
        print(element.data()! as Map<String, dynamic>);
        Lessons lesson =
        Lessons.fromMap(element.data()! as Map<String, dynamic>);
        lessonsList.add(lesson);
      });

      //sdfdsf
      for (Lessons lesson in lessonsList){
        // Reference to the lesson document
        DocumentReference lessonRef = FirebaseFirestore.instance.collection('usersExtended')
            .doc(userId).collection('enrolledCourses').doc(courseId).collection('lessons').doc(lesson.lessonTitle);

        // Set the document with the new fields, and merge if it already exists
        await lessonRef.set({
          'educatorId': educatorId,
          'isUnlocked': isUnlocked,
        });
        print(lesson.lessonTitle + "fields have been set");
      }

      print('Fields added successfully to the lesson document');
    } catch (e) {
      print('Error adding fields to lesson document: $e');
    }
  }

  //get single lesson details from users POV
  // Future<Map<String,dynamic>> getLessonDetailUser(){
  //
  // }
}
