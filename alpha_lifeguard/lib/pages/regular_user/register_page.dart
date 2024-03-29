import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_lifeguard/controllers/auth_controller.dart';
import 'package:alpha_lifeguard/pages/regular_user/otp_screen.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  var iColor = Colors.red;
  var iIcon = Icons.clear;
  var textLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(10, 80, 0, 0),
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.red[700],
                    ),
                    onPressed: () {
                      Get.back();
                    })),
            SizedBox(
                height: 190,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child:
                            Center(child: Image.asset('assets/word_logo.png'))),
                  ],
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(40), right: Radius.circular(40))),
                child: ListView(children: [
                  SizedBox(
                      height: 50,
                      child: Stack(
                        children: const <Widget>[
                          Positioned(
                              child: Center(
                                  child: Text("CITIZEN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold))))
                        ],
                      )),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    width: 220,
                                    child: TextFormField(
                                      controller: controller.phoneNo,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter number';
                                        }
                                        return null;
                                      },
                                      onChanged: (text) {
                                        setState(() {
                                          textLength = text.length;
                                        });
                                      },
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                7.0, 13.0, 0.0, 0.0),
                                            child: const Text(
                                              '+63',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                          ),
                                          suffixIcon: Container(
                                            height: 10,
                                            width: 10,
                                            margin: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: textLength == 10
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            child: Icon(
                                                textLength == 10
                                                    ? Icons.check
                                                    : Icons.clear,
                                                color: Colors.white,
                                                size: 19),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7))),
                                          hintText: 'Enter Number',
                                          errorStyle: const TextStyle(
                                              color: Colors.white)),
                                    ))
                              ]),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow[100],
                                    foregroundColor: Colors.red[700],
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (controller.phoneNo.text.length < 10 ||
                                          controller.phoneNo.text.length > 10) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Invalid Number!')));
                                      } else {
                                        AuthController.instance.phoneAuthentication(
                                            '+63${controller.phoneNo.text.trim()}');
                                        Get.to(() =>
                                            OtpScreen(controller.phoneNo.text));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please input correct number!')));
                                    }
                                  },
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(fontSize: 16),
                                  ))
                            ],
                          ),
                        ],
                      )),
                ])),
          ],
        )));
  }
}
