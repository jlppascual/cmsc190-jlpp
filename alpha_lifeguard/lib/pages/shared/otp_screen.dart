import 'package:alpha_lifeguard/pages/regular_user/userHome.dart';
import 'package:alpha_lifeguard/services/otp_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../services/auth.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

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
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          const Text(
            'OTP Verification',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
          ),
          const SizedBox(height: 30),
          const Text(
              "Please enter the OTP Code that we've sent through the number you provided"),
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter a 6-digit code!')));
                    } else {
                      debugPrint("OTP is => $_pinPutController");
                      OtpController.instance
                          .verifyOTP(context, _pinPutController.text);
                    }
                  },
                  child: const Text("Verify"))),
          const SizedBox(height: 20),
          const Text(
            "Didn't receive any code? ",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          const SizedBox(height: 20),
          const Text(
            "Resend New Code",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          )
        ],
      ),
    ));
  }
}
