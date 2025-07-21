import 'package:alpha_lifeguard/pages/regular_user/profile_page.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:alpha_lifeguard/pages/regular_user/home.dart';
import 'package:alpha_lifeguard/pages/regular_user/history_nav.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;

  //list of pages available to the user
  List<Widget> pageList = <Widget>[
    const HomeNav(),
    const HistoryNav(),
    const UserProfile()
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
        body: pageList.elementAt(_selectedIndex),
              floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
);
  }
}
