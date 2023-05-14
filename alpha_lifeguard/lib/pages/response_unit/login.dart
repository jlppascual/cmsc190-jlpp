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
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                          child: Center(
                              child: Image.asset('assets/word_logo.png'))),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 250),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.red[700]),
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
                                                color: Colors.white)),
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
                                              decoration:  InputDecoration(
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  labelText: "Enter Email",
                                                  labelStyle: const TextStyle(
                                                      color: Colors.white),
                                                  errorStyle: TextStyle(
                                                      color: Colors.yellow[100])),
                                              style: const TextStyle(
                                                  color: Colors.white),
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
                                                color: Colors.white)),
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
                                              decoration:  InputDecoration(
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  labelText: 'Enter Password',
                                                  labelStyle: const TextStyle(
                                                      color: Colors.white),
                                                  errorStyle: TextStyle(
                                                      color: Colors.yellow[100])),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(20),
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    var res = await ResponderLoginController
                                                        .instance
                                                        .login(
                                                            controller
                                                                .email.text
                                                                .trim(),
                                                            controller
                                                                .password.text
                                                                .trim());
                                                    if (res == true) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Successfully logged in!')));

                                                      Get.to(() =>
                                                          const ResponseNav());
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(res
                                                                  as String)));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Please fill up all fields properly!')));
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.yellow[100],
                                                    foregroundColor:
                                                        Colors.red[700]),
                                                child: const Text('LOGIN',
                                                    style: TextStyle(
                                                        fontSize: 15))))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            debugPrint(
                                                "Forgot password clicked!");
                                          },
                                          child: const Text('Forgot Password?',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ])))
                    ],
                  )),
            ])));
  }
}
