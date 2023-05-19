import 'package:alpha_lifeguard/models/user.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/main_home.dart';
import 'package:alpha_lifeguard/pages/regular_user/UserInfo.dart';
import 'package:alpha_lifeguard/pages/regular_user/main_home.dart';
import 'package:alpha_lifeguard/pages/response_unit/main_navigation.dart';
import 'package:alpha_lifeguard/pages/shared/welcome_screen.dart';
import 'package:alpha_lifeguard/services/establishment_services.dart';
import 'package:alpha_lifeguard/services/responder_service.dart';
import 'package:alpha_lifeguard/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encryptor/encryptor.dart';

import '../controllers/auth_controller.dart';
import '../models/establishment.dart';
import '../models/response_units.dart';

class UserAuthService extends GetxController {
  static UserAuthService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  final _controller = Get.put(AuthController());

  var verificationId =
      ''.obs; //RxString; will observe changes in the verificationId

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  String _userType = '';
  String get userType => _userType;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  String? _tempUid;
  String get tempUid => _tempUid!;

  //password key to encrypt.decrypt
  var key = '';

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _responderCollection =
      FirebaseFirestore.instance.collection('response_units');

  @override
  void onReady() {
    //currently logged in/ if logged out
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges()); //always listening to the user

    //listener, callback
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    final SharedPreferences s = await SharedPreferences.getInstance();

    if (user != null) {
      await Future.delayed(const Duration(seconds: 5), () async {
        //load

        // regularUser =
        //     await _firebaseFirestore.collection("users").doc(user.uid).get();
        // responseUnit = await _firebaseFirestore
        //     .collection("response_units")
        //     .doc(user.uid)
        //     .get();
        // establishment =
        //     await _firebaseFirestore.collection("users").doc(user.uid).get();
      });
    }

    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : s.getString("type") == 'user'
            ? s.getBool("newUser") == false
                ? Get.offAll(() => const UserMain())
                : Get.offAll(() => const UserInfoPage())
            : s.getString("type") == 'establishment'
                ? Get.offAll(() => const EstablishmentMain())
                : s.getString("type") == 'responder'
                    ? Get.offAll(() => const ResponseNav())
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
    _userType = s.getString("type") ?? 'none';
  }

  // register with phone number
  Future phoneAuthentication(String number) async {
    // await PhoneAuthCredential
    await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided number is not valid!');
          } else {
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

        //add user in firestore database if user does not exist yet
        if (await checkExistingUser() == false) {
          var regUser =
              RegularUser(uid: uid, phoneNumber: phoneNumber, role: role);
          await UserServices.instance.createUser(regUser);
        }
      }
      _isLoading = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('type', 'user');
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
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateName() async {
    try {
      _userCollection.doc(_uid).update({
        'firstName': _controller.firstName.text.trim(),
        'lastName': _controller.lastName.text.trim()
      });
      return true;
    } catch (e) {
      return ('ERROR: $e');
    }
  }

  //sign out
  Future userSignOut() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('type', 'none');

    try {
      await _auth.signOut();
      _isSignedIn = false;
      _userType = 'none';
      s.clear();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  //ESTABLISHMENT
  Future<dynamic> createEstablishment(
      String email, String password, String role, String type) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('type', 'establishment');

    var encryptedPassword = Encryptor.encrypt(key, password);

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: encryptedPassword);
      _uid = _auth.currentUser?.uid;

      var estab = Establishment(
          uid: uid,
          email: email,
          password: encryptedPassword,
          role: role,
          type: type);
      await EstablishmentServices.instance.createEstablishment(estab);
      return true;
    } on FirebaseAuthException catch (e) {
      return ("ERROR: ${e.code}");
    } catch (err) {
      return ("ERROR: ${err.toString()}");
    }
  }

  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('type', 'establishment');

    var encryptedPassword = Encryptor.encrypt(key, password);

    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: encryptedPassword);
      User? user = _auth.currentUser;
      _uid = user?.uid;
      return user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> addResponder(
      String firstName, String lastName, String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);

    var encryptedPassword = Encryptor.encrypt(key, password);

    try {
      await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
          email: email, password: encryptedPassword);
      _tempUid = FirebaseAuth.instanceFor(app: app).currentUser?.uid;
      _uid = _auth.currentUser?.uid;

      var estab = await _firebaseFirestore.collection('users').doc(uid).get();

      var unit = ResponseUnit(
          uid: tempUid,
          rsid: uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          type: estab['type'],
          password: password);
      await ResponderService.instance.createResponder(unit);
      app.delete();
      return true;
    } on FirebaseAuthException catch (e) {
      return ("ERROR: ${e.code}");
    } catch (err) {
      return ("ERROR: ${err.toString()}");
    }
  }

  //RESPONSE UNIT
  Future<dynamic> responderLogin(String email, String password) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('type', 'responder');

    var encryptedPassword = Encryptor.encrypt(key, password);

    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: encryptedPassword);
      User? user = _auth.currentUser;
      _uid = user?.uid;

      return user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> updateResponderName() async {
    try {
      _responderCollection.doc(_uid).update({
        'firstName': _controller.firstName.text.trim(),
        'lastName': _controller.lastName.text.trim()
      });
      return true;
    } catch (e) {
      return ('ERROR: $e');
    }
  }

    Future<dynamic> updateEstablishmentName() async {
    try {
      _userCollection.doc(_uid).update({
        'name': _controller.name.text.trim(),
      });
      return true;
    } catch (e) {
      return ('ERROR: $e');
    }
  }
}
