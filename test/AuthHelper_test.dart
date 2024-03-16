import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_lily/helperMethods/AuthHelper.dart';
// Create mock classes for Firebase Authentication classes
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('AuthHelper', () {
    late AuthHelper authHelper;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      authHelper = AuthHelper();
    });

    test('startSignUpUser - Successful Signup', () async {
      // Set up test data
      final String username = 'testUsername';
      final String email = 'test@example.com';
      final String password = 'testPassword';

      // Stub createUserWithEmailAndPassword method to return a successful result
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => MockUserCredential());

      // Stub Firestore method to return null for the set operation
      // when(mockFirebaseFirestore.collection('usersExtended').doc(any).set(any))
      //     .thenAnswer((_) async => null);

      // Call the method under test
      final result = await authHelper.startSignUpUser(username, email, password);

      // Verify that the result is true (success)
      expect(result, true);
    });

    test('startSignUpUser - Weak Password', () async {
      // Set up test data
      final String username = 'testUsername';
      final String email = 'test@example.com';
      final String weakPassword = '123'; // A weak password

      // Stub createUserWithEmailAndPassword method to throw weak password exception
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: weakPassword))
          .thenThrow(FirebaseAuthException(code: 'weak-password'));

      // Call the method under test
      final result = await authHelper.startSignUpUser(username, email, weakPassword);

      // Verify that the result is false (failure)
      expect(result, false);
    });

    test('startSignUpUser - Email Already in Use', () async {
      // Set up test data
      final String username = 'testUsername';
      final String email = 'test@example.com';
      final String password = 'testPassword';

      // Stub createUserWithEmailAndPassword method to throw email already in use exception
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      // Call the method under test
      final result = await authHelper.startSignUpUser(username, email, password);

      // Verify that the result is false (failure)
      expect(result, false);
    });

    // test('getUserRole - User Role Retrieved', () async {
    //   // Stub getCurrentUserId to return a user ID
    //   when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
    //   when(mockFirebaseAuth.currentUser!.uid).thenReturn('testUid');
    //
    //   // Stub Firestore method to return a document snapshot with role 'User'
    //   when(mockFirebaseFirestore.collection('usersExtended').doc('testUid').get())
    //       .thenAnswer((_) async => DocumentSnapshot<Map<String, dynamic>>(
    //       data: {'Role': 'User'}, exists: true));
    //
    //   // Call the method under test
    //   final role = await authHelper.getUserRole();
    //
    //   // Verify that the role is 'User'
    //   expect(role, 'User');
    // });

  });
}
