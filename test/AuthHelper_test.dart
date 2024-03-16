// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:project_lily/helperMethods/AuthHelper.dart';
//
// // Mock class for UserCredential
// class MockUserCredential extends Mock implements UserCredential {}
//
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
//
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
//
// void main() {
//   late AuthHelper authHelper;
//   late MockFirebaseAuth mockFirebaseAuth;
//   late MockFirebaseFirestore mockFirebaseFirestore;
//
//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockFirebaseFirestore = MockFirebaseFirestore();
//     authHelper = AuthHelper();
//   });
//
//   group('startSignUpUser', () {
//     test('should sign up user successfully', () async {
//       // Stubbing createUserWithEmailAndPassword method to return a mock UserCredential
//       when(mockFirebaseAuth.createUserWithEmailAndPassword(
//         email: anyNamed('email'),
//         password: anyNamed('password'),
//       )).thenAnswer((_) async => MockUserCredential());
//
//       // Stubbing the Firestore collection method
//       when(mockFirebaseFirestore.collection('usersExtended').doc(any).set(any))
//           .thenAnswer((_) async => {});
//
//       final result = await authHelper.startSignUpUser(
//         'testUsername',
//         'test@example.com',
//         'testPassword',
//       );
//
//       expect(result, true);
//     });
//
//     test('should handle weak password exception', () async {
//       // Stubbing createUserWithEmailAndPassword method to throw a FirebaseAuthException
//       when(mockFirebaseAuth.createUserWithEmailAndPassword(
//         email: anyNamed('email'),
//         password: anyNamed('password'),
//       )).thenThrow(FirebaseAuthException(code: 'weak-password'));
//
//       final result = await authHelper.startSignUpUser(
//         'testUsername',
//         'test@example.com',
//         'testPassword',
//       );
//
//       expect(result, false);
//     });
//
//     test('should handle email already in use exception', () async {
//       // Stubbing createUserWithEmailAndPassword method to throw a FirebaseAuthException
//       when(mockFirebaseAuth.createUserWithEmailAndPassword(
//         email: anyNamed('email'),
//         password: anyNamed('password'),
//       )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));
//
//       final result = await authHelper.startSignUpUser(
//         'testUsername',
//         'test@example.com',
//         'testPassword',
//       );
//
//       expect(result, false);
//     });
//   });
// }
