import 'package:cloud_firestore/cloud_firestore.dart';
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

  //save doll data in firebase

  Future<void> saveDataToFirestore(SqueezeTouchData data) async {
    try {
      // Access Firestore instance
      FirebaseFirestore db = FirebaseFirestore.instance;

      final squeezeTouchData = <String,String>{
        "SensorPartName":data.sensorPartName.toString(),
        "Pressure":data.sensorPartName.toString(),
        "DateTime":data.timestamp.toString(),
        "IsTouch":data.isTouch.toString(),
        "IsSqueeze":data.isSqueeze.toString(),
      };
      AuthHelper authHelper = new AuthHelper();
      String? userid = await authHelper.getCurrentUserId();

      // // Reference to a collection
      // CollectionReference mainCollectionRef = db.collection('squeezeTouches');
      //
      // // Data for the main document
      // Map<String, dynamic> mainDocumentData = {
      //
      // };
      //
      // // Add a document to the main collection
      // await mainCollectionRef.doc(userid!).set(mainDocumentData);
      //
      // DocumentReference mainDocumentRef = mainCollectionRef;
      //
      // CollectionReference subCollectionRef = mainDocumentRef.collection('sub_collection');

      db
          .collection("squeezeTouches")
          .doc(userid!)
          .collection("data")
          .doc()
          .set(squeezeTouchData);

      print('Data saved successfully!');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  // //add details to custom 'user' db

}