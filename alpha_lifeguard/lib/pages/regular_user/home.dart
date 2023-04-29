import 'package:alpha_lifeguard/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  double contWidth = 100;
  double contHeight = 80;

  String selectedType = '';
  final desc = TextEditingController();
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

  _getImage() async {
    XFile? selectedFile = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (selectedFile != null) {
      setState(() {
        _imageFile = selectedFile;
      });
    }
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
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.location_pin, color: Colors.red),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Current Location",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ))),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
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
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
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
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
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
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
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
                        border: Border.all(width: 2, color: Colors.blue),
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
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
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
                            borderRadius: BorderRadius.all(Radius.circular(7))),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[50],
                          foregroundColor: Colors.red[700]),
                      onPressed: () {
                        _getImage();
                      },
                      child: SizedBox(
                          width: 120,
                          child: Row(children: const [
                            Text('Attach Image '),
                            Icon(Icons.image)
                          ]))),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700]),
                    onPressed: () {
                      if (selectedType == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Incident Type not selected!')));
                      }
                      DateTime today = DateTime.now();
                      String date =
                          '${months[today.month - 1]}. ${today.day}, ${today.year}';
                      String time =
                          '${(today.hour > 12 ? today.hour - 12 : today.hour)}:${(today.minute.bitLength < 2 ? "0${today.minute}" : today.minute)} ${(today.hour > 12 ? "PM" : "AM")}';

                      try {
                        FirestoreService.instance.sendReports(selectedType, desc.text, date, time);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Report sent!')));

                            setState(() {
                              selectedType = '';
                              desc.clear();
                            });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: const Text('REPORT')))
          ],
        )));
  }
}
