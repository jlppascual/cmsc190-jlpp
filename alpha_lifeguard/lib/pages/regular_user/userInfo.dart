import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_lifeguard/controllers/auth_controller.dart';

import '../../services/user_auth.dart';
import 'main_home.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

final _formKey = GlobalKey<FormState>();
final controller = Get.put(AuthController());
var iColor = Colors.red;
var iIcon = Icons.clear;
var textLength = 0;

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child:
                            Center(child: Image.asset('assets/word_logo.png'))),
                  ],
                )),
            Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 200),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.red[700],
                ),
                child: Column(children: [
                  const SizedBox(height: 30),
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
                                  Text("First Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.yellow[100])),
                                  SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: controller.firstName,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please complete field';
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
                                            labelText: "Enter First Name",
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
                                  Text("Last Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.yellow[100])),
                                  SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: controller.lastName,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please complied field';
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
                                            labelText: 'Enter Last Name',
                                            labelStyle: TextStyle(
                                                color: Colors.yellow[100]),
                                            errorStyle: const TextStyle(
                                                color: Colors.white)),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ])),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[100],
                                foregroundColor: Colors.red[700],
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var res =
                                     await UserAuthService.instance.updateName();

                                  if (res == true) {
                                    Get.offAll(() => const UserMain());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(res as String)));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please fill up all fields properly!')));
                                }
                              },
                              child: const Text('CONTINUE')))
                    ],
                  ),
                ])),
          ],
        )));
  }
}
