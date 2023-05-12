import 'package:alpha_lifeguard/controllers/responder_login.dart';
import 'package:alpha_lifeguard/pages/response_unit/main_navigation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResponseLogin extends StatefulWidget {
  const ResponseLogin({super.key});

  @override
  State<ResponseLogin> createState() => _ResponseLoginState();
}

class _ResponseLoginState extends State<ResponseLogin> {
  final controller = Get.put(ResponderLoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 80, 0, 0),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      })),
              Container(
                padding: const EdgeInsets.all(50),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 250),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.yellow[100]),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        const Text("Email: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black)),
                                        SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              controller: controller.email,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Please enter email';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  labelText: "Enter Email",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("Password: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black)),
                                        SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              controller: controller.password,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Please enter password';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  labelText: 'Enter Password',
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(20),
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                var res =
                                                    await ResponderLoginController
                                                        .instance
                                                        .login(
                                                            controller
                                                                .email.text
                                                                .trim(),
                                                            controller
                                                                .password.text
                                                                .trim());
                                                if (res == true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Successfully logged in!')));

                                                  Get.to(() =>
                                                      const ResponseNav());
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              res as String)));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Please fill up all fields properly!')));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                backgroundColor:
                                                    Colors.red[700],
                                                foregroundColor:
                                                    Colors.yellow[100]),
                                            child: const Text('LOGIN',
                                                style:
                                                    TextStyle(fontSize: 15)))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            debugPrint(
                                                "Forgot password clicked!");
                                          },
                                          child: Text('Forgot Password?',
                                              style: TextStyle(
                                                  color: Colors.red[700])),
                                        ),
                                      ],
                                    ),
                                  ])))
                    ],
                  )),
            ])));
  }
}
