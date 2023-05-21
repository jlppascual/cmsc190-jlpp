import 'dart:io';

import 'package:alpha_lifeguard/utils/map_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:alpha_lifeguard/services/user_service.dart';
import 'package:uuid/uuid.dart';
import 'maps_page.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final ImagePicker _picker = ImagePicker();
  double? progress;
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/cmsc190-lifeguard.appspot.com/o/reports%2Fdefault.jpg?alt=media&token=ffe3854a-12c1-47a8-bc4d-d9b9e6355c94';
  String imagePath = '';
  XFile? _imageFile;

  double contWidth = 100;
  double contHeight = 80;

  Map<String, dynamic> currLocation = MapConstants.defaultLatLng;

  String selectedType = '';
  final desc = TextEditingController();
  String location = "Current Location";

  setLocation(String value) {
    setState(() {
      location = value;
    });
  }

  setCoordinates(Map<String,dynamic> coordinates){
    setState(() {
      currLocation = coordinates;
    });
  }

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  UploadTask? uploadTask;

  Future uploadReportImage() async {
    var ridGenerator = const Uuid(); //creates unique ids

    var fileName = ridGenerator.v4();

    final path = 'reports/$fileName';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.red),
              child: const Padding(
                  padding: EdgeInsets.fromLTRB(25, 60, 15, 15),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "File a Report",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Let us know what happened",
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        )
                      ],
                    )
                  ])),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.yellow[100]),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: SizedBox(
                            width: 330,
                            child: InkWell(
                              hoverColor: Colors.red[100],
                              onTap: (() => Get.to(() => UserMapsPage(
                                  setCoordinates: setCoordinates,
                                  setString: setLocation))),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black54)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_pin,
                                          color: Colors.red),
                                      Flexible(
                                          child: Text(
                                        '$location',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14),
                                      ))
                                    ],
                                  )),
                            )
                            // TextField(
                            //   onTap: () {
                            //     Get.to(() =>
                            //         UserMapsPage(currLocation: currLocation, setString: setLocation));
                            //   },
                            //   decoration: InputDecoration(
                            //       prefixIcon: Icon(Icons.location_pin,
                            //           color: Colors.red),
                            //       filled: true,
                            //       fillColor: Colors.white,
                            //       labelText: location,
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(10)))),
                            // )

                            )),
                    const SizedBox(height: 10),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Type of Incident',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: contWidth,
                              height: contHeight,
                              decoration: BoxDecoration(
                                  color: selectedType == 'medical'
                                      ? Colors.green
                                      : Colors.white,
                                  border:
                                      Border.all(width: 2, color: Colors.green),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedType = 'medical';
                                          debugPrint(selectedType);
                                        });
                                      },
                                      icon: Icon(Icons.add,
                                          color: selectedType == 'medical'
                                              ? Colors.white
                                              : Colors.green)),
                                  Text(
                                    "MEDICAL",
                                    style: TextStyle(
                                        color: selectedType == 'medical'
                                            ? Colors.white
                                            : Colors.green),
                                  )
                                ],
                              )),
                          Container(
                              width: contWidth,
                              height: contHeight,
                              decoration: BoxDecoration(
                                  color: selectedType == 'fire'
                                      ? Colors.red
                                      : Colors.white,
                                  border:
                                      Border.all(width: 2, color: Colors.red),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedType = 'fire';
                                          debugPrint(selectedType);
                                        });
                                      },
                                      icon: Icon(Icons.warning,
                                          color: selectedType == 'fire'
                                              ? Colors.white
                                              : Colors.red)),
                                  Text("FIRE",
                                      style: TextStyle(
                                          color: selectedType == 'fire'
                                              ? Colors.white
                                              : Colors.red))
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: contWidth,
                              height: contHeight,
                              decoration: BoxDecoration(
                                  color: selectedType == 'crime'
                                      ? Colors.black
                                      : Colors.white,
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedType = 'crime';
                                          debugPrint(selectedType);
                                        });
                                      },
                                      icon: Icon(Icons.warehouse,
                                          color: selectedType == 'crime'
                                              ? Colors.white
                                              : Colors.black)),
                                  Text("CRIME",
                                      style: TextStyle(
                                          color: selectedType == 'crime'
                                              ? Colors.white
                                              : Colors.black))
                                ],
                              )),
                          Container(
                            width: contWidth,
                            height: contHeight,
                            decoration: BoxDecoration(
                                color: selectedType == 'rescue'
                                    ? Colors.blue
                                    : Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.blue),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedType = 'rescue';
                                        debugPrint(selectedType);
                                      });
                                    },
                                    icon: Icon(Icons.airplanemode_active,
                                        color: selectedType == 'rescue'
                                            ? Colors.white
                                            : Colors.blue)),
                                Text("RESCUE",
                                    style: TextStyle(
                                        color: selectedType == 'rescue'
                                            ? Colors.white
                                            : Colors.blue))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Incidental Report (Optional)',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                          width: 380,
                          child: TextField(
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                helperText:
                                    'Would you like to describe in detail what happened?',
                                hintText: 'What happened?'),
                            controller: desc,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 20),
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
                        _imageFile == null
                            ? const Text(' No file selected ')
                            : Text(_imageFile!.name)
                      ],
                    ),
                    buildProgress(),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[700]),
                              onPressed: () {
                                if (selectedType == '') {
                                  Get.snackbar(
                                      'ERROR:', 'Select an incident type!');
                                } else {
                                  DateTime today = DateTime.now();
                                  String date =
                                      '${months[today.month - 1]}. ${today.day}, ${today.year}';
                                  String time =
                                      '${(today.hour > 12 ? today.hour - 12 : today.hour)}:${(today.minute.bitLength < 2 ? "0${today.minute}" : today.minute)} ${(today.hour > 12 ? "PM" : "AM")}';

                                  try {
                                    Future.delayed(Duration.zero, () async {
                                      buildProgress();
                                    });
                                    UserServices.instance.sendReports(
                                        selectedType,
                                        desc.text,
                                        imagePath,
                                        imageUrl,
                                        date,
                                        time,
                                        location,
                                        currLocation);
                                    Get.snackbar('SUCCESS:', 'REPORT SENT!');

                                    setState(() {
                                      selectedType = '';
                                      desc.clear();
                                      _imageFile = null;
                                    });
                                  } catch (e) {
                                    Get.snackbar('ERROR:', '$e');
                                  }
                                }
                              },
                              child: const Text('REPORT')),
                        ))
                  ],
                ))
          ],
        )));
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
              height: 30,
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
}
