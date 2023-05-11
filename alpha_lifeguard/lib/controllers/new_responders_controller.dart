import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondersController extends GetxController{
  static RespondersController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();

//get phoneNo from user and pass it to Auth Repository for Firebase Authentication

  dynamic emailAndPasswordAuthentication(String email, String firstName, String lastName, String password){
    var res = UserAuthService.instance.addResponder(firstName, lastName, email, password);
    return res;
  }
}