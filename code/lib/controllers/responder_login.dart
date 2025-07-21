import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponderLoginController extends GetxController{
  static ResponderLoginController get instance => Get.find();

  final password = TextEditingController();
  final email = TextEditingController();

//get phoneNo from user and pass it to Auth Repository for Firebase Authentication

  dynamic login(String email, String password){
    var res = UserAuthService.instance.responderLogin(email, password);
    return res;
  }
}