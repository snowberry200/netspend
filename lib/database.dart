import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database();
  final firestore = FirebaseFirestore.instance;
  Future<Map<String, dynamic>> getInfo(
      String username, dynamic password) async {
    final Map<String, dynamic> data = {
      'userName': username,
      'passWord': password
    };
    try {
      firestore.collection('credentials').add(data);
    } catch (e) {
      log(e.toString());
    }
    return data;
  }

  Future<Map<String, dynamic>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final Map<String, dynamic> signupData = {
      'name': name,
      'userName': email,
      'passWord': password
    };
    try {
      firestore.collection('credentials').add(signupData);
    } catch (e) {
      log(e.toString());
    }
    return signupData;
  }
}
