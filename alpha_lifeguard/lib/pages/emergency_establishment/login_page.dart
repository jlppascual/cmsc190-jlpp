import 'package:alpha_lifeguard/pages/emergency_establishment/main_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class EstablishmentLogin extends StatefulWidget {
  const EstablishmentLogin({super.key});

  @override
  State<EstablishmentLogin> createState() => _EstablishmentLoginState();
}

class _EstablishmentLoginState extends State<EstablishmentLogin> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
              SizedBox(
                  height: 180,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          child: Center(
                              child: Image.asset('assets/word_logo.png'))),
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(40), right: Radius.circular(40))),
                child: Column(children: [
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 15, 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                     Text("Email: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.yellow[100])),
                                    SizedBox(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller.email,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              labelText: "Enter Email",
                                              labelStyle: TextStyle(
                                                  color: Colors.yellow[100]),
                                              errorStyle: const TextStyle(
                                                  color: Colors.white)),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                       Text("Password: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.yellow[100])),
                                      SizedBox(
                                          width: 200,
                                          child: TextFormField(
                                            controller: controller.password,
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Please enter password';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                labelText: 'Enter Password',
                                                labelStyle: TextStyle(
                                                    color: Colors.yellow[100]),
                                                errorStyle: const TextStyle(
                                                    color: Colors.white)),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ))
                                    ]),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 40, 20, 20),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                var res = await AuthController
                                                    .instance
                                                    .signInWithEmailAndPassword(
                                                        controller.email.text
                                                            .trim(),
                                                        controller.password.text
                                                            .trim());
                                                if (res == true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Successfully logged in!')));
                                                  Get.to(() =>
                                                      const EstablishmentMain());
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
                                                backgroundColor:
                                                    Colors.yellow[100],
                                                foregroundColor: Colors.red),
                                            child: const Text('LOGIN',
                                                style:
                                                    TextStyle(fontSize: 15))))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account?",
                                        style: TextStyle(color: Colors.white)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Register!',
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent),
                                      ),
                                    ),
                                  ],
                                ),
                              ])))
                ]),
              )
            ])));
  }
}
