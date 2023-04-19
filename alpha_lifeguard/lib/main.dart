import 'package:alpha_lifeguard/firebase_options.dart';
import 'package:alpha_lifeguard/pages/regular_user/userHome.dart';
import 'package:alpha_lifeguard/pages/regular_user/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alpha_lifeguard/pages/shared/welcome_screen.dart';
import 'package:alpha_lifeguard/pages/regular_user/register.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/register.dart';
import 'package:alpha_lifeguard/services/auth.dart';
import 'package:get/get.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthService()));
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. debug provider
  //   // 2. safety net provider
  //   // 3. play integrity provider
  //   androidProvider: AndroidProvider.debug,
  // );
  // runApp(const MaterialApp(
  //   debug ShowCheckedModeBanner: false,
  //   home: MyApp(),
  // ))
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "LifeGuard",
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/user/register': (context) => const UserRegister(),
        '/establishment/register': (context) => const EstablishmentRegister(),
        '/user/home': (context) => const UserHome()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
