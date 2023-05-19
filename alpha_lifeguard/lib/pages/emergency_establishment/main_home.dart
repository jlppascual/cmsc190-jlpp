import 'package:alpha_lifeguard/pages/emergency_establishment/home_page.dart';
import 'package:alpha_lifeguard/pages/emergency_establishment/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/new_responders_controller.dart';
// import 'package:image_picker/image_picker.dart';

class EstablishmentMain extends StatefulWidget {
  const EstablishmentMain({super.key});

  @override
  State<EstablishmentMain> createState() => _EstablishmentMainState();
}

class _EstablishmentMainState extends State<EstablishmentMain> {
  final controller = Get.put(RespondersController());

  int _selectedIndex = 0;

  List<Widget> pageList = <Widget>[
    const EstablishmentHome(),
    const EstablishmentProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.yellow[100],
            selectedItemColor: Colors.red[600],
            unselectedItemColor: Colors.black45,
            elevation: 90,
            onTap: (index) => {
                  setState(() {
                    _selectedIndex = index;
                  })
                },
            currentIndex: _selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded), label: 'Profile'),
            ]),
        body: pageList.elementAt(_selectedIndex));
  }
}
