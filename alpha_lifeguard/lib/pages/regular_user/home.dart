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
              decoration: BoxDecoration(color: Colors.red),
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
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                debugPrint("medical clicked!");
                              },
                              icon: const Icon(Icons.add, color: Colors.green)),
                          const Text(
                            "MEDICAL",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      )),
                  Container(
                      width: contWidth,
                      height: contHeight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                debugPrint("fire clicked!");
                              },
                              icon:
                                  const Icon(Icons.warning, color: Colors.red)),
                          const Text("FIRE",
                              style: TextStyle(color: Colors.red))
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
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                debugPrint("crime clicked!");
                              },
                              icon: const Icon(Icons.warehouse,
                                  color: Colors.black)),
                          const Text("CRIME",
                              style: TextStyle(color: Colors.black))
                        ],
                      )),
                  Container(
                    width: contWidth,
                    height: contHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.blue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              debugPrint("rescue clicked!");
                            },
                            icon: const Icon(Icons.airplanemode_active,
                                color: Colors.blue)),
                        const Text("RESCUE",
                            style: TextStyle(color: Colors.blue))
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                  width: 380,
                  child: TextField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          helperText:
                              'Would you like to describe in detail what happened?',
                          hintText:
                              'Would you like to describe in detail what happened?'))),
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
                      debugPrint("Report clicked!");
                    },
                    child: const Text('REPORT')))
          ],
        )));
  }
}
