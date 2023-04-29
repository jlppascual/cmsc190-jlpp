import 'package:alpha_lifeguard/pages/emergency_establishment/main_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_controller.dart';

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
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
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
              Column(children: [
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
                                  const Text("Email ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
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
                                        decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: "Enter Email",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            errorStyle:
                                                TextStyle(color: Colors.red)),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Password ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black)),
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
                                              errorStyle:
                                                  TextStyle(color: Colors.red)),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ))
                                  ]),
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          var res = await AuthController
                                              .instance
                                              .signInWithEmailAndPassword(
                                                  controller.email.text.trim(),
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
                                                    content:
                                                        Text(res as String)));
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
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.red),
                                      child: const Text('LOGIN',
                                          style: TextStyle(fontSize: 15)))),
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
              ])
            ])));
  }
}
