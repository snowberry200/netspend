import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database();

  final firestore = FirebaseFirestore.instance;

  // Simulated method to get user info from Firestore
  Future<Map<String, dynamic>> getInfo(String username, String password) async {
    try {
      final querySnapshot = await firestore
          .collection("credentials")
          .where('userName', isEqualTo: username)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();
      if (querySnapshot.docs.isEmpty) {
        throw Exception('invalid username or password');
      }
      log('User found: ${querySnapshot.docs.first.data()}');
      return querySnapshot.docs.first.data();
    } catch (e) {
      log('Error fetching user info: $e');
      rethrow;
    }
  }
  // Future<Map<String, dynamic>> getInfo(String username, String password) async {
  //   try {
  //     final querySnapshot = await firestore
  //         .collection('credentials')
  //         .where('userName', isEqualTo: username)
  //         .where('passWord', isEqualTo: password)
  //         .limit(1)
  //         .get();
  //     if (querySnapshot.docs.isNotEmpty) {
  //       throw Exception('invalid username or password');
  //     }

  //     //return user data
  //     final userData = querySnapshot.docs.first.data();
  //     log('User found: $userData');
  //     return userData;
  //   } catch (e) {
  //     log('Error fetching user info: $e');
  //     rethrow;
  //   }
  // }

  // This should be for SIGN UP - creating new user
  Future<void> signUp({
    required String? name,
    required String username,
    required String pass,
  }) async {
    try {
      // First check if user already exists
      final existingUser = await firestore
          .collection('credential')
          .where('user', isEqualTo: username)
          .limit(1)
          .get();

      if (existingUser.docs.isNotEmpty) {
        throw Exception('User with this email already exists');
      }

      // Create new user
      final data = {
        'name': name,
        'user': username,
        'password': pass,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Add to Firestore and wait for completion
      await firestore.collection('credential').add(data);

      log('User created successfully: $username');
    } catch (e) {
      log('signUp error: $e');
      rethrow; // IMPORTANT: rethrow so Bloc can catch the error
    }
  }
}
