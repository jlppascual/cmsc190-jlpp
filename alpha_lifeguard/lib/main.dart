import 'package:alpha_lifeguard/firebase_options.dart';
import 'package:alpha_lifeguard/pages/regular_user/login_page.dart';
import 'package:alpha_lifeguard/pages/regular_user/main_home.dart';
import 'package:alpha_lifeguard/services/firestore_service.dart';
import 'package:alpha_lifeguard/services/maps_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alpha_lifeguard/pages/shared/welcome_screen.dart';
import 'package:alpha_lifeguard/pages/regular_user/register_page.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/register_page.dart';
import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var type = prefs.getString("type");
  debugPrint(type);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => {
            Get.put(UserAuthService()),
            Get.put(FirestoreService()),
            Get.put(MapServices())
          });
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
        '/user/login': (context) => const UserLogin(),
        '/user/home': (context) => const UserMain(),
        '/establishment/register': (context) => const EstablishmentRegister(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
