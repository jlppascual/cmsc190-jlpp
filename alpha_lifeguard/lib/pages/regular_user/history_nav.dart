import 'package:alpha_lifeguard/pages/regular_user/report_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/user_service.dart';

class HistoryNav extends StatefulWidget {
  const HistoryNav({super.key});

  @override
  State<HistoryNav> createState() => _HistoryNavState();
}

class _HistoryNavState extends State<HistoryNav> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
          child:const Padding(
            padding:  EdgeInsets.fromLTRB(15, 45, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Details of reports you sent so far',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: StreamBuilder(
                stream: UserServices.instance.getUserReports(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('no reports sent yet!');
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
                                  children: const [
                                    Text('DATE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('TYPE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('TIME',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('STATUS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const Divider(
                                  height: 20,
                                  thickness: 2,
                                  indent: 15,
                                  endIndent: 15,
                                  color: Colors.black45,
                                )
                              ],
                            );
                          } else {
                            index -= 1;
                            return InkWell(
                                onTap: () {
                                  Get.to(() => UserReportDetailsPage(
                                      desc: snapshot.data!.docs[index]
                                          .get('desc'),
                                      time: snapshot.data!.docs[index]
                                          .get('time'),
                                      finished: snapshot.data!.docs[index]
                                          .get('finished'),
                                      addressed: snapshot.data!.docs[index]
                                          .get('addressed'),
                                      date: snapshot.data!.docs[index]
                                          .get('date'),
                                      rid:
                                          snapshot.data!.docs[index].get('rid'),
                                      userLoc: snapshot.data!.docs[index]
                                          .get('coordinates')));
                                },
                                child: Column(
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
                                          Text(snapshot.data!.docs[index]
                                              .get('date')),
                                          Text(snapshot.data!.docs[index]
                                              .get('type')),
                                          Text(snapshot.data!.docs[index]
                                              .get('time')),
                                          TextButton(
                                              onPressed: () {
                                                debugPrint(snapshot
                                                            .data!.docs[index]
                                                            .get('finished') ==
                                                        true
                                                    ? 'resolved'
                                                    : snapshot.data!.docs[index]
                                                                .get(
                                                                    'addressed') ==
                                                            true
                                                        ? 'acknowledged'
                                                        : 'new');
                                              },
                                              style: TextButton.styleFrom(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5))),
                                                  backgroundColor: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  'finished') ==
                                                          true
                                                      ? Colors.green
                                                      : snapshot.data!.docs[index].get('addressed') ==
                                                              true
                                                          ? Colors.yellow[700]
                                                          : Colors.red,
                                                  foregroundColor:
                                                      Colors.white),
                                              child: Text(snapshot
                                                          .data!.docs[index]
                                                          .get('finished') ==
                                                      true
                                                  ? 'resolved'
                                                  : snapshot.data!.docs[index]
                                                              .get('addressed') ==
                                                          true
                                                      ? 'acknowledged'
                                                      : 'new'.toString().toUpperCase())),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      indent: 15,
                                      endIndent: 15,
                                      color: Colors.black45,
                                    )
                                  ],
                                ));
                          }
                        });
                  }
                }))
      ],
    );
  }
}
