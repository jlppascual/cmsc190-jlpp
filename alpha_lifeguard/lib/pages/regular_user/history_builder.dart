import 'package:flutter/material.dart';

import '../../services/firestore_service.dart';

class HistoryBuilder extends StatefulWidget {
  const HistoryBuilder({super.key});

  @override
  State<HistoryBuilder> createState() => _HistoryBuilderState();
}

class _HistoryBuilderState extends State<HistoryBuilder> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreService.instance.getUserReports(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('no reports sent yet!');
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  return Row(
                    children: [
                      Column(
                        children: [
                          Text(snapshot.data!.docs[index].get('date')),
                          Text(snapshot.data!.docs[index].get('type')),
                          Text(snapshot.data!.docs[index].get('time')),
                          TextButton(
                              onPressed: () {
                                debugPrint(snapshot.data!.docs[index]
                                            .get('finished') ==
                                        true
                                    ? 'resolved'
                                    : snapshot.data!.docs[index]
                                                .get('addressed') ==
                                            true
                                        ? 'acknowledged'
                                        : 'new');
                              },
                              child: Text(
                                  snapshot.data!.docs[index].get('finished') ==
                                          true
                                      ? 'resolved'
                                      : snapshot.data!.docs[index]
                                                  .get('addressed') ==
                                              true
                                          ? 'acknowledged'
                                          : 'new'))
                        ],
                      )
                    ],
                  );
                });
          }
        });
    // return ListView.builder(
    //     itemCount: tempList.length,
    //     itemBuilder: (context, int index) {
    //       return Row(
    //         children: [
    //           Column(
    //             children: [
    //               Text(tempList[index]['date']),
    //               Text(tempList[index]['type']),
    //               Text(tempList[index]['time']),
    //               TextButton(
    //                   onPressed: () {
    //                     debugPrint(tempList[index]['status']);
    //                   },
    //                   child: Text(tempList[index]['status']))
    //             ],
    //           )
    //         ],
    //       );
    //     });
  }
}
