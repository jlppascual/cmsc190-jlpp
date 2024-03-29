import 'dart:io';

import 'package:alpha_lifeguard/services/responder_service.dart';
import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../controllers/auth_controller.dart';

class RespondersProfile extends StatefulWidget {
  const RespondersProfile({super.key});

  @override
  State<RespondersProfile> createState() => _RespondersProfileState();
}

final controller = Get.put(AuthController());
TextEditingController currPassword = TextEditingController();
TextEditingController newPassword = TextEditingController();
TextEditingController newEmail = TextEditingController();

bool currObscured = true;
bool newObscured = true;

final _formKey = GlobalKey<FormState>();

class _RespondersProfileState extends State<RespondersProfile> {
  String imageUrl = '';
  String imagePath = '';
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  double? progress;
  UploadTask? uploadTask;

  Future uploadReportImage() async {
    var ridGenerator = const Uuid(); //creates unique ids

    var fileName = ridGenerator.v4();

    final path = 'displaypics/$fileName';
    final file = File(_imageFile!.path);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      imageUrl = urlDownload;
      imagePath = path;
    });
  }

  _getImage() async {
    XFile? selectedFile = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (selectedFile != null) {
      setState(() {
        _imageFile = selectedFile;
      });
    }

    uploadReportImage();
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
              height: 30,
              width: 100,
              child: Stack(fit: StackFit.expand, children: [
                LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green[700]),
                Center(
                    child: Text('${100 * progress.roundToDouble()}%',
                        style: const TextStyle(color: Colors.white)))
              ]));
        } else {
          return const SizedBox(height: 30);
        }
      });

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
                                              decoration:  InputDecoration(
                                                suffixIcon: IconButton(
                                                    color: Colors.black87,
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
                                                    color: Colors.black87,
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
                                  var res = await ResponderService.instance
                                      .changeResponderPassword(
                                          currPassword.text.trim(),
                                          newPassword.text.trim());

                                  if (_formKey.currentState!.validate()) {
                                    if (res == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Password changed successfully!')));
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(res as String)));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Error in updating password!')));
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              StreamBuilder(
                  stream: ResponderService.instance.getStreamResponderDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('');
                    } else {
                      return Column(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.red[700],
                                child: CircleAvatar(
                                  radius: 53,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs[0].get('imageUrl')),
                                )),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data!.docs[0]
                                                        .get('imageUrl')),
                                                    fit: BoxFit.contain))));
                                  });
                            },
                          ),
                          Text(
                            '${snapshot.data!.docs[0].get('firstName')} ${snapshot.data!.docs[0].get('lastName')}',
                            style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.w600,
                                fontSize: 30),
                          )
                        ],
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
                            _updatePasswordModal(context);
                          },
                          child: const Row(
                            children: [
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 400,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 30),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                    ),
                                                    child: _imageFile == null
                                                        ? Center(
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                children: [
                                                                  const Text(
                                                                      'no image selected yet')
                                                                ]),
                                                          )
                                                        : Image.file(
                                                            File(_imageFile!
                                                                .path),
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          )),
                                                buildProgress(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 120,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                            'select picture'),
                                                        onPressed: _getImage,
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 160,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                            'change picture'),
                                                        onPressed: () async {
                                                          var res =
                                                              await ResponderService
                                                                  .instance
                                                                  .updateProfilePicture(
                                                                      imageUrl);

                                                          if (res == true) {
                                                            Get.snackbar(
                                                                'SUCCESS:',
                                                                'Profile Picture successfully changed');
                                                          } else {
                                                            Get.snackbar(
                                                                'ERROR:',
                                                                '$res');
                                                          }
                                                        },
                                                      )),
                                                )
                                              ],
                                            )));
                                  });
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.camera_alt_rounded),
                                Text(' '),
                                Text("Edit Profile Picture")
                              ],
                            ))),
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
                          child: const Row(
                            children: [
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

void _updateEmailModal(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                              if (val == null || val.isEmpty) {
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
                                            controller: currPassword,
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Please enter your password';
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
                                var res = await ResponderService.instance
                                    .changeResponderEmail(newEmail.text.trim(),
                                        currPassword.text.trim());

                                if (_formKey.currentState!.validate()) {
                                  if (res == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Password changed successfully!')));
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(res as String)));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Error in updating password!')));
                                }
                              },
                              child: const Text('UPDATE')),
                          const SizedBox(height: 30),
                        ]))));
      });
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
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: "Enter First Name",
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: "Enter Last Name",
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
                                .updateResponderName();

                            if (res == true) {
                              Get.snackbar(
                                  'SUCCESS: ', 'Name changed successfully');
                              controller.firstName.clear();
                              newPassword.clear();
                              newEmail.clear();
                              controller.lastName.clear();

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
