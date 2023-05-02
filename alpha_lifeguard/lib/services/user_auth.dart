import 'package:alpha_lifeguard/models/user.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/main_home.dart';
import 'package:alpha_lifeguard/pages/regular_user/main_home.dart';
import 'package:alpha_lifeguard/pages/shared/welcome_screen.dart';
import 'package:alpha_lifeguard/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/establishment.dart';

class UserAuthService extends GetxController {
  static UserAuthService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  var verificationId =
      ''.obs; //RxString; will observe changes in the verificationId

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;

  @override
  void onReady() {
    //currently logged in/ if logged out
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges()); //always listening to the user

    //listener, callback
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    DocumentSnapshot? storeUser;

    if (user != null) {
      await Future.delayed(const Duration(seconds: 5), () {
        //load
      });
      storeUser =
          await _firebaseFirestore.collection("users").doc(user.uid).get();
    }

    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : storeUser?['role'] == 'regular_user'
            ? Get.offAll(() => const UserMain())
            : storeUser?['role'] == 'regular_user'
                ? Get.offAll(() => const EstablishmentMain())
                : {
                    //do nothing
                  };
  }

// REGULAR USER OPERATIONS

  authProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    //key value pairs
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
  }

  // register with phone number
  Future phoneAuthentication(String number) async {
    // await PhoneAuthCredential
    // can optionally add recaptcha (hower ka sa number)

    await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            debugPrint('Error The provided number is not valid!');

            Get.snackbar('Error', 'The provided number is not valid!');
          } else {
            debugPrint('Error: ${e.code}');

            Get.snackbar('Error', e.code);
          }
        },
        codeSent: (String verificationId, resendToken) async {
          this.verificationId.value = verificationId;
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value =
              verificationId; //if there is change or we resend the code after some time of interval
        });
  }

  Future<bool> verifyOTP({
    required BuildContext context,
    required String otp,
    required String phoneNumber,
    required String role,
  }) async {
    _isLoading = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp);

      User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;

        //add user in firestore database

        var regUser =
            RegularUser(uid: uid, phoneNumber: phoneNumber, role: role);
        await FirestoreService.instance.createUser(regUser);
        // }
      }
      _isLoading = false;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      _isLoading = false;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      _isLoading = false;
    }
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp));
      return credentials.user != null ? true : false;
    } on FirebaseAuthException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();

    if (snapshot.exists) {
      debugPrint("User exist");
      return true;
    } else {
      debugPrint("New User");
      return false;
    }
  }

  //sign out
  Future userSignOut() async {
    final SharedPreferences s = await SharedPreferences.getInstance();

    try {
      await _auth.signOut();
      _isSignedIn = false;
      s.clear();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  //ESTABLISHMENT
  Future<dynamic> createEstablishment(
      String email, String password, String role) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      debugPrint(_auth.currentUser?.uid);
      _uid = _auth.currentUser?.uid;

      var estab =
          Establishment(uid: uid, email: email, password: password, role: role);
      await FirestoreService.instance.createEstablishment(estab);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("ERROR: ${e.code}");
      return ("ERROR: ${e.code}");
    } catch (err) {
      debugPrint("ERROR: ${err.toString()}");
      return ("ERROR: ${err.toString()}");
    }
  }

  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = _auth.currentUser;
      _uid = user?.uid;
      return user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
