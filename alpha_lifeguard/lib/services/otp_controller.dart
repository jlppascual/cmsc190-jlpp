import 'package:alpha_lifeguard/pages/regular_user/userHome.dart';
import 'package:alpha_lifeguard/pages/shared/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/services/auth.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  void verifyOTP(BuildContext context, String otp) async {
    var isExisting = false;
    var isVerified = await AuthService.instance.verifyOTP(
        context: context,
        otp: otp,
        onSuccess: () {
          AuthService.instance.checkExistingUser().then((value) async {
            debugPrint("VALUE$value");
            if (value == true) {
              isExisting = true;
            } else {
              isExisting = false;
            }
          });
        });
    debugPrint("$isVerified $isExisting");
    isVerified == true
        ? isExisting == false
            ? Get.offAll(() => const UserHome())
            : Get.back()
        : Get.back();
  }
}
