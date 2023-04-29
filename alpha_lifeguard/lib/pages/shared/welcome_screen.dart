import 'package:alpha_lifeguard/pages/response_unit/login.dart';
import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/pages/regular_user/register_page.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/register_page.dart';

class WelcomeScreen  extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
                height: 400,
                //decoration
                child: Stack(
                  children: const <Widget>[
                    Positioned(
                        child: Center(
                            child: Text("LIFEGUARD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)))),
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserRegister()));
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red),
              child: const Text('Regular User'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EstablishmentRegister()));
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white),
              child: const Text('Emergency Establishment'),
            ),ElevatedButton(
              onPressed: () {
                debugPrint("response unit clicked");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResponseLogin()));
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white),
              child: const Text('Response Unit'),
            ),
          ],
        )));
  }
}
