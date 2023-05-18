import 'package:alpha_lifeguard/pages/response_unit/history_page.dart';
import 'package:alpha_lifeguard/pages/response_unit/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/pages/response_unit/home.dart';

class ResponseNav extends StatefulWidget {
  const ResponseNav({super.key});

  @override
  State<ResponseNav> createState() => _ResponseNavState();
}

class _ResponseNavState extends State<ResponseNav> {
  int _selectedIndex = 0;

  //list of pages available to the user
  List<Widget> pageList = <Widget>[
    const ResponseHome(),
    const ResponseUnitHistory(),
    const RespondersProfile()
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
          elevation: 70,
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
                icon: Icon(Icons.alarm), label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded), label: 'Profile'),
          ],
        ),
        body: pageList.elementAt(_selectedIndex));
  }
}
