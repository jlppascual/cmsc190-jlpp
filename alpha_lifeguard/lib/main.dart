import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'package:alpha_lifeguard/pages/regular_user/register.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/register.dart';


// ...
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false,
    home: LoginPage(),)
  );
}


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                      child: Center(child: Text("REGISTER", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)))),

                  ],)
              ), 

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserRegister()));
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: Colors.white, foregroundColor: Colors.red),
                child: const Text('Regular User'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const EstablishmentRegister()));
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: Colors.black, foregroundColor: Colors.white),
                child: const Text('Emergency Establishment'),
              ),
            ],             
          )
      )
    );
  }
}