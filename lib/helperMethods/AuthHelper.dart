import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  //start sign up for user
  Future<bool> startSignUpUser(
      String username, String email, String password) async {
    bool isSuccess = false;
    try {
      //add details to built in 'auth' service
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      isSuccess = true;
      print(credential.user?.uid);
      //add details to custom 'user' db
      FirebaseFirestore db = FirebaseFirestore.instance;

      final user = <String, String>{
        "Username": username,
        "PhoneNum": "",
        "Level": "",
        "Role": "User"
      };
      db.collection("usersExtended").doc(credential.user!.uid).set(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return isSuccess;
  }

  //start sign up for educator
  Future<bool> startSignUpEducator(
      String username, String email, String password) async {
    bool isSuccess = false;
    try {
      //add details to built in 'auth' service
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      isSuccess = true;
      print(credential.user?.uid);
      //add details to custom 'user' db
      FirebaseFirestore db = FirebaseFirestore.instance;

      final user = <String, String>{
        "Username": username,
        "PhoneNum": "",
        "Level": "",
        "Role": "Educator"
      };
      db.collection("usersExtended").doc(credential.user!.uid).set(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return isSuccess;
  }

  //get application user role [User/Educator]
  Future<String> getUserRole() async {
    String userType = "User";
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot dbSnapshot = await db.collection("usersExtended").doc(await getCurrentUserId()).get();

    if (dbSnapshot.exists) {
      userType =(dbSnapshot.data() as Map<String,dynamic>)["Role"]!;
    }

    return userType;
  }

//  start login process method
  Future<bool> startLogin(String email, String password) async {
    bool isSuccess = false;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      //if success sign in
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      //do smtg if sign in fail
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return isSuccess;
  }

  //get user uid
  Future<String?> getCurrentUserId() async {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    // Return the user ID if the user is not null
    return user?.uid;
  }

  Future<String?> getCurrentUsername(String userId) async {
    try {
      // Reference to the document in the 'usersExtended' collection
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('usersExtended')
          .doc(userId)
          .get();

      // Check if the document exists and contains the 'Username' field
      if (userDoc.exists && userDoc.data() != null && userDoc.data()!.containsKey('Username')) {
        // Retrieve and return the 'Username' field from the document
        return userDoc.data()!['Username'];
      } else {
        // Document does not exist or Username field is missing
        return null;
      }
    } catch (error) {
      // Handle any errors that occur during the process
      print('Error retrieving Username: $error');
      return null;
    }
  }
}
