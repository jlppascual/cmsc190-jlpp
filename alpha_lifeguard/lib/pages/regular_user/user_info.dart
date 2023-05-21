import 'dart:io';

import 'package:alpha_lifeguard/services/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_lifeguard/controllers/auth_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/user_auth.dart';
import 'main_home.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

final _formKey = GlobalKey<FormState>();
final controller = Get.put(AuthController());
var iColor = Colors.red;
var iIcon = Icons.clear;
var textLength = 0;

class _UserInfoPageState extends State<UserInfoPage> {
  String imageUrl = '';
  String imagePath = '';
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();
  double? progress;
  UploadTask? uploadTask;

  Future uploadReportImage() async {
    final path = 'reports/${_imageFile!.name}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(10, 80, 0, 0),
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.red[700],
                    ),
                    onPressed: () {
                      Get.back();
                    })),
            SizedBox(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child:
                            Center(child: Image.asset('assets/word_logo.png'))),
                  ],
                )),
            Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 200),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.red[700],
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 77,
                          backgroundImage: NetworkImage(imageUrl),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[50],
                            foregroundColor: Colors.red[700]),
                        onPressed: () {
                          _getImage();
                        },
                        child: const SizedBox(
                            width: 120,
                            child: Row(children: [
                              Text('Attach Image '),
                              Icon(Icons.image)
                            ]))),
                  ),
                  buildProgress(),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("First Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.yellow[100])),
                                  SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: controller.firstName,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please complete field';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: "Enter First Name",
                                            labelStyle: TextStyle(
                                                color: Colors.yellow[100]),
                                            errorStyle: const TextStyle(
                                                color: Colors.white)),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Last Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.yellow[100])),
                                  SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: controller.lastName,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please complete the field';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: 'Enter Last Name',
                                            labelStyle: TextStyle(
                                                color: Colors.yellow[100]),
                                            errorStyle: const TextStyle(
                                                color: Colors.white)),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                            ])),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[100],
                                foregroundColor: Colors.red[700],
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await UserAuthService.instance.updateName();
                                  await UserServices.instance
                                      .updateProfilePicture(imageUrl);

                                  final SharedPreferences s =
                                      await SharedPreferences.getInstance();

                                  await s.setBool("newUser", false);
                                  Get.to(() => const UserMain());
                                } else {
                                  Get.snackbar('ERROR: ',
                                      'Please fill up all fields properly');
                                }
                              },
                              child: const Text('CONTINUE')))
                    ],
                  ),
                ])),
          ],
        )));
  }
}
