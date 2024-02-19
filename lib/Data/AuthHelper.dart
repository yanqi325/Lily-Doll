import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {

   Future<bool> startSignUp(String username, String email, String password) async {
    bool isSuccess = false;
    try {
      //add details to built in 'auth' service
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      isSuccess = true;
      print(credential.user?.uid);
      //add details to custom 'user' db
      FirebaseFirestore db = FirebaseFirestore.instance;

      final user = <String,String>{
        "Username":username,
        "PhoneNum":"",
        "Level":""
      };
      db
          .collection("usersExtended")
          .doc(credential.user!.uid)
          .set(user);
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

  Future<bool> startLogin(String email, String password) async{
     bool isSuccess = false;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!
      );
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
}