import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/login.dart';

class EstablishmentRegister extends StatefulWidget {
  const EstablishmentRegister({super.key});

  @override
  State<EstablishmentRegister> createState() => _EstablishmentRegister();
}

class _EstablishmentRegister extends State<EstablishmentRegister>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  height: 150,
                  child: Stack(
                    children: const <Widget>[
                      Positioned(
                          child: Center(
                              child: Text("REGISTER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold))))
                    ],
                  ))
            ]),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 200),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.yellow[100],
                ),
                child: Column(children: [
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
                                  const Text("Email ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                  SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: emailController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter email';
                                          }
                                          return null;
                                        },
                                        // onChanged: (text) {
                                        //   debugPrint('textfield : $text');
                                        // },
                                        decoration: const InputDecoration(
                                            // filled: true,
                                            // fillColor: Colors.white,
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
                                        controller: passwordController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter password';
                                          }
                                          return null;
                                        },
                                        // onChanged: (text) {
                                        //   debugPrint('textfield : $text');
                                        // },
                                        decoration: const InputDecoration(
                                            // filled: true,
                                            // fillColor: Colors.white,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: 'Enter Password',
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            errorStyle:
                                                TextStyle(color: Colors.red)),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ))
                                ],
                              )
                            ])),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            foregroundColor: Colors.yellow[100],
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //KULANG NG NAV
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const EstablishmentNav()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Successfully registered!')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Error in registering!')));
                            }
                          },
                          child: const Text('Register'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                          style: TextStyle(color: Colors.black)),
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
