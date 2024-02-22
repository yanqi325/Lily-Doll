import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_lily/Data/SqueezeTouchData.dart';
import 'package:project_lily/helperMethods/AuthHelper.dart';

class DbHelper{
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

      final squeezeTouchData = <String,String>{
        "SensorPartName":data.sensorPartName.toString(),
        "Pressure":data.sensorPartName.toString(),
        "DateTime":data.timestamp.toString(),
        "IsTouch":data.isTouch.toString(),
        "IsSqueeze":data.isSqueeze.toString(),
      };

      // Reference to the 'usersExtended' collection
      CollectionReference usersExtendedCollectionRef = firestore.collection('usersExtended');

      // Reference to the 'SquuezeTouches' document within 'usersExtended'
      DocumentReference userDocumentRef = usersExtendedCollectionRef.doc(userid!);

      CollectionReference squeezeTouchesDocumentRef = userDocumentRef.collection('SquuezeTouches');


      var date = DateFormat('d-M-y').format(DateTime.now());
      // Reference to the 'date' subcollection within 'SquuezeTouches' document
      DocumentReference dateSubcollectionRef = squeezeTouchesDocumentRef.doc(date);

      // Add a document to the 'date' subcollection with a custom ID
      CollectionReference hourRef = dateSubcollectionRef.collection(data.hour.toString());

      await hourRef.add(squeezeTouchData);

      print('Document added successfully to the date subcollection');
    } catch (e) {
      print('Error adding document to the date subcollection: $e');
    }
  }

  //

}