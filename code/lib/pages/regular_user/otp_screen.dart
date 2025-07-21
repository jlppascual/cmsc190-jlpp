import 'package:alpha_lifeguard/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../controllers/auth_controller.dart';

class OtpScreen extends StatefulWidget {
  // const OtpScreen({super.key});
  static OtpScreen get instance => Get.find();
  final String phone;

  const OtpScreen(this.phone, {super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController otpController = Get.put(OtpController());
  final TextEditingController _pinPutController = TextEditingController();
  final controller = Get.put(AuthController());

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 50, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'OTP Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              )),
          const SizedBox(height: 30),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                  "Please enter the OTP Code that we've sent through the number you provided")),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: defaultPinTheme,
                  controller: _pinPutController,
                  pinAnimationType: PinAnimationType.fade,
                  onCompleted: (pin) async {
                    _pinPutController.text = pin;
                  })),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_pinPutController.text.length < 6) {
                      Get.snackbar('WARNING: ', 'Please enter a 6-digit code!');
                    } else {
                      OtpController.instance.verifyOTP(
                          context,
                          _pinPutController.text,
                          controller.phoneNo.text.trim(),
                          'regular_user');
                    }
                  },
                  child: const Text("Verify"))),
          const SizedBox(height: 20),
          const Text(
            "Didn't receive any code? ",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          const SizedBox(height: 10),
          TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red[700],
              ),
              onPressed: () {
                AuthController.instance.phoneAuthentication(
                    '+63${controller.phoneNo.text.trim()}');
              },
              child: const Text("Resend New Code")),
        ],
      ),
    ));
  }
}
