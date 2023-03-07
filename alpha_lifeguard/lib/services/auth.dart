import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //function to create firebase user obj
  // RegUser _userFromFireBaseUser(User user){
  //   return RegUser(uid: user.uid);
  // }

  //auth change user stream
  // Stream<User> get authStateChanges => _auth.authStateChanges()
  // .map(_userFromFireBaseUser as User Function(User? event));

  // register with email and password

  Future createUser(String email, String password) async {
    try {
      // await PhoneAuthCredential
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password'){
        debugPrint('The password provided is too weak');
      }else if(e.code == 'number-already-in-use'){
        debugPrint('the account already exists for that number');
      }
    } 
    catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
