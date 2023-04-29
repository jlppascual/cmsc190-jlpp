import 'package:alpha_lifeguard/pages/regular_user/main_home.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
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
                            labelText: "Enter phone number"),
                      ))),
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserMain()))
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
                  const Text("Don't have an account?",
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Register!', style: TextStyle(color: Colors.lightBlueAccent),),
                  ),
                ],
              ),
            ])));
  }
}
