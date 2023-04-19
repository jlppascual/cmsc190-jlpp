import 'package:alpha_lifeguard/pages/regular_user/userHome.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResponseLogin extends StatefulWidget {
  const ResponseLogin({super.key});

  @override
  State<ResponseLogin> createState() => _ResponseLoginState();
}

class _ResponseLoginState extends State<ResponseLogin> {
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
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            labelText: "Enter email or phone number"),
                      ))),
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            labelText: "Enter password"),
                      ))),
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserHome()))
                          },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red),
                      child:
                          const Text('LOGIN', style: TextStyle(fontSize: 15)))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      debugPrint("Forgot password clicked!");
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ])));
  }
}
