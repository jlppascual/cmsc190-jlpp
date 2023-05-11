import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/new_responders_controller.dart';
import '../../services/firestore_service.dart';

class EstablishmentHome extends StatefulWidget {
  const EstablishmentHome({super.key});

  @override
  State<EstablishmentHome> createState() => _EstablishmentHomeState();
}

final controller = Get.put(RespondersController());

_newRespondersModal(context) {
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
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Email: '),
                          SizedBox(
                              width: 170,
                              child: TextFormField(
                                controller: controller.email,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter email';
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
                                    labelText: "Enter Email",
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
                            var res = await UserAuthService.instance
                                .addResponder(
                                    controller.firstName.text.trim(),
                                    controller.lastName.text.trim(),
                                    controller.email.text.trim(),
                                    'LifeGuard!2023');

                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Successfully registered!')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res as String)));
                            }
                          },
                          child: const Text('Create Account'))
                    ],
                  ))),
        );
      });
}

class _EstablishmentHomeState extends State<EstablishmentHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'LIFEGUARD',
                style: TextStyle(color: Colors.yellow[100]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(8)),
          child: StreamBuilder(
              stream: FirestoreService.instance.getEstablishmentResponders(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  debugPrint('no data!');
                  return Row(
                    children: const [
                      Text('there are no existing responder units yet',
                          style: TextStyle(color: Colors.black))
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length + 1,
                      itemBuilder: (context, int index) {
                        if (index == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('NAME',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  ElevatedButton(
                                      onPressed: () {
                                        _newRespondersModal(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Text('Add Responders'),
                                          Icon(Icons.add)
                                        ],
                                      ))
                                ],
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 15,
                                endIndent: 15,
                                color: Colors.black45,
                              )
                            ],
                          );
                        } else {
                          index -= 1;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      left: Radius.circular(2),
                                                      right:
                                                          Radius.circular(2)),
                                              color: Colors.yellow[100]),
                                          child: Row(children: [
                                            Text(snapshot.data!.docs[index]
                                                .get('firstName')),
                                                const Text(' '),
                                            Text(snapshot.data!.docs[index]
                                                .get('lastName'))
                                          ]))
                                    ],
                                  )),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                indent: 15,
                                endIndent: 15,
                                color: Colors.black45,
                              )
                            ],
                          );
                        }
                      });
                }
              }),
        )),
      ],
    );
  }
}
