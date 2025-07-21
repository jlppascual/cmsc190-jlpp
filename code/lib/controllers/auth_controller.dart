import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final phoneNo = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final name = TextEditingController();
  final role = TextEditingController();
  String type = 'medical';

//get phoneNo from user and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNo) {
    UserAuthService.instance.phoneAuthentication(phoneNo);
  }

  dynamic emailAndPasswordAuthentication(
      String email, String password, String role, String type) {
    var res = UserAuthService.instance
        .createEstablishment(email, password, role, type);
    return res;
  }

  dynamic signInWithEmailAndPassword(String email, String password) {
    var res =
        UserAuthService.instance.loginWithEmailAndPassword(email, password);
    return res;
  }
}
