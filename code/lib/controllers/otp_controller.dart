import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  void verifyOTP(
      BuildContext context, String otp, String phoneNumber, String role) async {
    var isVerified = await UserAuthService.instance.verifyOTP(
      context: context,
      otp: otp,
      phoneNumber: phoneNumber,
      role: role,
    );

    Future.delayed(Duration.zero, () async {
      if (isVerified == true) {
        var doesExist = await UserAuthService.instance.checkExistingUser();

        if (doesExist == true) {
          final SharedPreferences s = await SharedPreferences.getInstance();
          await s.setBool('newUser', false);
        } else {
          final SharedPreferences s = await SharedPreferences.getInstance();
          await s.setBool('newUser', true);
        }
      }
      // isVerified == true ? Get.offAll(() => const UserMain()) : Get.back();
    });
  }
}
