import 'package:alpha_lifeguard/services/establishment_services.dart';
import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class EstablishmentProfile extends StatefulWidget {
  const EstablishmentProfile({super.key});

  @override
  State<EstablishmentProfile> createState() => _EstablishmentProfileState();
}

final controller = Get.put(AuthController());
final _formKey = GlobalKey<FormState>();

class _EstablishmentProfileState extends State<EstablishmentProfile> {
  bool newObscured = true;
  bool currObscured = true;

  TextEditingController currPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newEmail = TextEditingController();

  void _updateEmailModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.circular(20.0)),
                  constraints: const BoxConstraints(maxHeight: 450),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 40, 12, 12),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'CHANGE EMAIL',
                              style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text('New Email: '),
                                        SizedBox(
                                            width: 140,
                                            child: TextFormField(
                                              controller: newEmail,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Please enter your new email';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  labelText: "Enter New Email",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text('Password: '),
                                        SizedBox(
                                            width: 170,
                                            child: TextFormField(
                                              obscureText: currObscured,
                                              controller: currPassword,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Please enter your password';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    color: Colors.white,
                                                    icon: currObscured == true
                                                        ? Icon(Icons
                                                            .visibility_off)
                                                        : Icon(Icons
                                                            .visibility),
                                                    onPressed: () {
                                                      setState(() {
                                                        currObscured =
                                                            !currObscured;
                                                      });
                                                    },
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  labelText: "Enter Password",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                  ],
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.yellow[100]),
                                onPressed: () async {
                                  dynamic res = await EstablishmentServices
                                      .instance
                                      .changeEstablishmentEmail(
                                          newEmail.text.trim(),
                                          currPassword.text.trim());

                                  if (_formKey.currentState!.validate()) {
                                    debugPrint('res = $res');
                                    if (res == true) {
                                      Get.snackbar('SUCCESS',
                                          'Email changed successfully!');

                                      Navigator.pop(context);
                                    } else {
                                      Get.snackbar('ERROR', '$res');
                                    }
                                  } else {
                                    Get.snackbar(
                                        'ERROR', 'Error in updating password!');
                                  }
                                },
                                child: const Text('UPDATE')),
                            const SizedBox(height: 30),
                          ]))));
        });
  }

  void _updatePasswordModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                              'CHANGE PASSWORD',
                              style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text('Current Password: '),
                                        SizedBox(
                                            width: 140,
                                            child: TextFormField(
                                              obscureText: currObscured,
                                              controller: currPassword,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Please enter your current password';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    color: Colors.white,
                                                    icon: currObscured == true
                                                        ? Icon(Icons
                                                            .visibility_off)
                                                        : Icon(Icons
                                                            .visibility),
                                                    onPressed: () {
                                                      setState(() {
                                                        currObscured =
                                                            !currObscured;
                                                      });
                                                    },
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  labelText:
                                                      "Enter Current Password",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text('New Password: '),
                                        SizedBox(
                                            width: 170,
                                            child: TextFormField(
                                              obscureText: newObscured,
                                              controller: newPassword,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Please enter your new password';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    color: Colors.white,
                                                    icon: newObscured == true
                                                        ? Icon(Icons
                                                            .visibility_off)
                                                        : Icon(Icons
                                                            .visibility),
                                                    onPressed: () {
                                                      setState(() {
                                                        newObscured =
                                                            !newObscured;
                                                      });
                                                    },
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  labelText:
                                                      "Enter New Password",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 50),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.yellow[100]),
                                onPressed: () async {
                                  var res = await EstablishmentServices.instance
                                      .changeEstablishmentPassword(
                                          currPassword.text.trim(),
                                          newPassword.text.trim());

                                  if (_formKey.currentState!.validate()) {
                                    if (res == true) {
                                      Get.snackbar('SUCCESS',
                                          'Password changed successfully!');

                                      Navigator.pop(context);
                                    } else {
                                      Get.snackbar('ERROR', '$res');
                                    }
                                  } else {
                                    Get.snackbar(
                                        'ERROR', 'Error in updating password!');
                                  }
                                },
                                child: const Text('UPDATE')),
                            const SizedBox(height: 30),
                          ]))));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              StreamBuilder(
                  stream: EstablishmentServices.instance
                      .getStreamEstablishmentDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('');
                    } else {
                      return Text(
                        '${snapshot.data!.docs[0].get('name')}',
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
                            _updateNameModal(context);
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
                            _updatePasswordModal(context);
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
                            _updateEmailModal(context);
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
                            UserAuthService.instance.userSignOut();
                          },
                          child: Row(
                            children: const [
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(' Name: '),
                                  SizedBox(
                                      width: 170,
                                      child: TextFormField(
                                        controller: controller.name,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter new name';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: "Enter Name",
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            errorStyle:
                                                TextStyle(color: Colors.red)),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 100),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              foregroundColor: Colors.yellow[100]),
                          onPressed: () async {
                            var res = await UserAuthService.instance
                                .updateEstablishmentName();

                            if (res == true) {
                              Get.snackbar(
                                  'SUCCESS:', 'Name changed successfully!');

                              Navigator.pop(context);
                            } else {
                              Get.snackbar('ERROR', '$res');
                            }
                          },
                          child: const Text('UPDATE'))
                    ],
                  ))),
        );
      });
}
