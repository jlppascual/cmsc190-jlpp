import 'package:flutter/material.dart';

class EstablishmentLogin extends StatefulWidget {
  const EstablishmentLogin({super.key});

  @override
  State<EstablishmentLogin> createState() => _EstablishmentLoginState();
}

class _EstablishmentLoginState extends State<EstablishmentLogin> {
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
                      onPressed: () => {debugPrint("login clicked!")},
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
                    child: const Text('Register!'),
                  ),
                ],
              ),
            ])));
  }
}