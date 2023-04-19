import 'package:alpha_lifeguard/pages/regular_user/userHome.dart';
import 'package:alpha_lifeguard/pages/shared/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  static AuthService get instance => Get.find();

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

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const UserHome());
  }

// REGULAR USER OPERATIONS

  authProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    //key value pairs
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    // notifyListeners();
  }

  Future<void> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } catch (_) {}
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

  Future<bool> verifyOTP(
      {required BuildContext context,
      required String otp,
      required Function onSuccess}) async {
    _isLoading = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp);

      User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      _isLoading = false;
    }
    debugPrint(verificationId.value);
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    debugPrint("uid:$_uid");
    debugPrint("snapshot!!!=>${snapshot.id}");
    debugPrint("${snapshot.exists}");
    if (snapshot.id == _uid) {
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

  //EMERGENCY ESTABLISHMENT
}
