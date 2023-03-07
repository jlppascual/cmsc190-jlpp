import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/login.dart';

class EstablishmentRegister extends StatefulWidget {
  const EstablishmentRegister({super.key});

  @override
  State<EstablishmentRegister> createState() => _EstablishmentRegister();
}

class _EstablishmentRegister extends State<EstablishmentRegister>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                  height: 400,
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
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text("+63 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white)),
                  SizedBox(
                      width: 200,
                      child: TextField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        labelText: 'Enter Number',
                      )))
                ]),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?',
                    style: TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const EstablishmentLogin()));
                  },
                  child: const Text('Sign in!'),
                ),
              ],
            ),
          ],
        )));
  }
}
