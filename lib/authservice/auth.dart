import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //_auth is an object ( an instance of the class AuthService)
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //signing in with email and Password
  Future signIn({required email, required password}) async {
    // because _auth is serving as a variable to Access FirebaseAuth.
    // we can access all the sign in methods available on firebaseAuthentication via it
    // There,
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
