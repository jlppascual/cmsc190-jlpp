import 'package:alpha_lifeguard/pages/regular_user/main_home.dart';
import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:get/get.dart';

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
    Future.delayed(Duration.zero, () {
      isVerified == true ? Get.offAll(() => const UserMain()) : Get.back();
    });
  }
}
