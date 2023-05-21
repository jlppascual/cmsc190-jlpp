import 'package:alpha_lifeguard/pages/emergency_establishment/response_unit_details.dart';
import 'package:alpha_lifeguard/services/establishment_services.dart';
import 'package:alpha_lifeguard/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/new_responders_controller.dart';

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
              constraints: const BoxConstraints(maxHeight: 400),
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
                      const SizedBox(height: 20),
                      const Text('Default Password: LifeGuard!2023'),
                      const SizedBox(height: 20),
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
                              Get.snackbar(
                                  'SUCCESS: ', 'Successfully registered!');
                              controller.firstName.clear();
                              controller.lastName.clear();
                              controller.email.clear();
                            } else {
                              Get.snackbar('ERROR: ', '$res');
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.red),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Text(
                    'LIFEGUARD',
                    style: TextStyle(
                        color: Colors.yellow[100],
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ))
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(8)),
          child: StreamBuilder(
              stream:
                  EstablishmentServices.instance.getEstablishmentResponders(),
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length + 1,
                          itemBuilder: (context, int index) {
                            if (index == 0) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    ResponseUnitDetails(
                                                        firstName: snapshot
                                                            .data!.docs[index]
                                                            .get('firstName'),
                                                        lastName: snapshot
                                                            .data!.docs[index]
                                                            .get('lastName'),
                                                        email: snapshot
                                                            .data!.docs[index]
                                                            .get('email')));
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .horizontal(
                                                              left: Radius
                                                                  .circular(2),
                                                              right: Radius
                                                                  .circular(2)),
                                                      color:
                                                          Colors.yellow[100]),
                                                  child: Row(children: [
                                                    Text(snapshot
                                                        .data!.docs[index]
                                                        .get('firstName')),
                                                    const Text(' '),
                                                    Text(snapshot
                                                        .data!.docs[index]
                                                        .get('lastName'))
                                                  ])))
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
                          }),
                    )
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text('Awaiting result...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              }),
        )),
      ],
    );
  }
}
