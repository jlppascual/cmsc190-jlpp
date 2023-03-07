import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 53,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/09/b3/34/09b334fd23b9be6a472a2f3eada61759.jpg'),
                  ))
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700]),
                          onPressed: () {
                            debugPrint("Edit Name Clicked");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.person_outline_rounded),
                              Text(' '),
                              Text("Edit Name")
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700]),
                          onPressed: () {
                            debugPrint("Edit Password Clicked");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.key_rounded),
                              Text(' '),
                              Text("Edit Password")
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700]),
                          onPressed: () {
                            debugPrint("Edit Email Clicked");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.email_rounded),
                              Text(' '),
                              Text("Edit Email")
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700]),
                          onPressed: () {
                            debugPrint("Edit Number Clicked");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.phone_android_rounded),
                              Text(' '),
                              Text("Edit Number")
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700]),
                          onPressed: () {
                            debugPrint("Delete Account Clicked");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.delete_forever),
                              Text(' '),
                              Text("Delete Account")
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700]),
                          onPressed: () {
                            debugPrint("Location sharing clicked");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.pin_drop),
                              Text(' '),
                              Text("Turn off location sharing")
                            ],
                          )),
                    )
                  ],
                )
              ],
            )),
      ],
    ));
  }
}
