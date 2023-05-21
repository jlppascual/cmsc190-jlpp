import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/login_page.dart';

import '../../controllers/auth_controller.dart';

class EstablishmentRegister extends StatefulWidget {
  const EstablishmentRegister({super.key});

  @override
  State<EstablishmentRegister> createState() => _EstablishmentRegister();
}

class _EstablishmentRegister extends State<EstablishmentRegister>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;

  final controller = Get.put(AuthController());
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
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
                padding: const EdgeInsets.fromLTRB(10, 70, 0, 0),
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
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child:
                            Center(child: Image.asset('assets/word_logo.png'))),
                  ],
                )),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 200),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.red[700],
                ),
                child: Column(children: [
                  const Center(
                      child: Text("REGISTER",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold))),
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
                                            color: Colors.white),
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
                                        obscureText: isObscured,
                                        controller: controller.password,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter password';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              color: Colors.white,
                                              icon: isObscured == true
                                                  ? Icon(Icons.visibility_off)
                                                  : Icon(Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  isObscured = !isObscured;
                                                });
                                              },
                                            ),
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
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text("Type: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.yellow[100])),
                                  DropdownButton<String>(
                                    hint: const Text('Select'),
                                    value: controller.type.toString(),
                                    items: <String>[
                                      'medical',
                                      'fire',
                                      'crime',
                                      'rescue'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black)));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        controller.type = newValue!;
                                      });
                                    },
                                  )
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
                                  var res = await AuthController.instance
                                      .emailAndPasswordAuthentication(
                                          controller.email.text.trim(),
                                          controller.password.text.trim(),
                                          'establishment',
                                          controller.type.toString().trim());

                                  if (res == true) {
                                    Get.snackbar(
                                        'SUCCESS', 'Successfully registered!');
                                    controller.email.clear();
                                    controller.password.clear();
                                  } else {
                                    Get.snackbar('ERROR', '$res!');
                                  }
                                } else {
                                  Get.snackbar('ERROR',
                                      'Please fill up all fields properly');
                                }
                              },
                              child: const Text('REGISTER')))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EstablishmentLogin()));
                        },
                        child: const Text(
                          'Sign in!',
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                      ),
                    ],
                  )
                ])),
          ],
        )));
  }
}
