import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../services/user_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

final controller = Get.put(AuthController());

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 53,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/09/b3/34/09b334fd23b9be6a472a2f3eada61759.jpg'),
                  )),
              const SizedBox(height: 20),
              StreamBuilder(
                  stream: UserServices.instance.getUserDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('');
                    } else {
                      return Text(
                        '${snapshot.data!.docs[0].get('firstName')} ${snapshot.data!.docs[0].get('lastName')}',
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      );
                    }
                  })
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                            _updateNameModal(context);
                          },
                          child: const Row(
                            children: [
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
                            debugPrint("Edit Number Clicked");
                          },
                          child: const Row(
                            children:  [
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
                          child: const Row(
                            children:  [
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
                          child: const Row(
                            children: [
                              Icon(Icons.pin_drop),
                              Text(' '),
                              Text("Turn off location sharing")
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
                            UserAuthService.instance.userSignOut();
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.logout_rounded),
                              Text(' '),
                              Text("Log Out")
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

void _updateNameModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(20.0)),
                constraints: const BoxConstraints(maxHeight: 450),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 40, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'EDIT NAME',
                          style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('First Name: '),
                            SizedBox(
                                width: 170,
                                child: TextFormField(
                                  controller: controller.firstName,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      labelText: "Enter First Name",
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      errorStyle: TextStyle(color: Colors.red)),
                                  style: const TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Last Name: '),
                            SizedBox(
                                width: 170,
                                child: TextFormField(
                                  controller: controller.lastName,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      labelText: "Enter Last Name",
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      errorStyle: TextStyle(color: Colors.red)),
                                  style: const TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        const SizedBox(height: 100),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700],
                                foregroundColor: Colors.yellow[100]),
                            onPressed: () async {
                              var res =
                                  await UserAuthService.instance.updateName();

                              if (res == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Name changed successfully!')));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(res as String)));
                              }
                            },
                            child: const Text('UPDATE'))
                      ],
                    ))),
          );
        });
  }
