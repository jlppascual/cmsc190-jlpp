import 'package:alpha_lifeguard/pages/response_unit/login.dart';
import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/pages/regular_user/register_page.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/register_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child:
                            Center(child: Image.asset('assets/word_logo.png'))),
                  ],
                )),
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(40), right: Radius.circular(40))),
                child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserRegister()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red),
                              child: const Text('Regular User'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EstablishmentRegister()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white),
                              child: const Text('Emergency Establishment'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResponseLogin()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white),
                              child: const Text('Response Unit'),
                            ),
                          ),
                        )
                      ],
                    )))
          ],
        )));
  }
}
