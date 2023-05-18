import 'package:alpha_lifeguard/pages/response_unit/report_details.dart';
import 'package:alpha_lifeguard/services/responder_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponseHome extends StatefulWidget {
  const ResponseHome({super.key});

  @override
  State<ResponseHome> createState() => _ResponseHomeState();
}

class _ResponseHomeState extends State<ResponseHome> {
  DocumentSnapshot? snapshotUser;

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    Future.delayed(Duration.zero, () async {
      snapshotUser = await _getResponderInfo();
      return;
    });
  }

  Future<DocumentSnapshot> _getResponderInfo() async {
    var res = await ResponderService.instance.getResponderDetails();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder(
            stream: ResponderService.instance.getResponderReports(),
            builder: (context, AsyncSnapshot snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Container(
                    width: 500,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            'Details of reports sent so far!',
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('DATE',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('TYPE',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('TIME',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('STATUS',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => ReportDetailsPage(
                                          desc: snapshot.data!.docs[index]
                                              .get('desc'),
                                          time: snapshot.data!.docs[index]
                                              .get('time'),
                                          date: snapshot.data!.docs[index]
                                              .get('date'),
                                          finished: snapshot.data!.docs[index]
                                              .get('finished'),
                                          addressed: snapshot.data!.docs[index]
                                              .get('addressed'),
                                          rid: snapshot.data!.docs[index]
                                              .get('rid'),
                                          uid: snapshot.data!.docs[index]
                                              .get('uid'),
                                          userLoc: snapshot.data!.docs[index]
                                              .get('coordinates')));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                            '${snapshot.data!.docs[index].get('date')}'),
                                        Text(
                                            '${snapshot.data!.docs[index].get('type')}'),
                                        Text(
                                            '${snapshot.data!.docs[index].get('time')}'),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                ResponderService.instance
                                                    .addressReport(snapshot
                                                        .data!.docs[index]
                                                        .get('rid'));
                                              });
                                            },
                                            style: TextButton.styleFrom(
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5))),
                                                backgroundColor: snapshot
                                                            .data!.docs[index]
                                                            .get('finished') ==
                                                        true
                                                    ? Colors.green
                                                    : snapshot.data!.docs[index].get('addressed') ==
                                                            true
                                                        ? Colors.yellow[700]
                                                        : Colors.red,
                                                foregroundColor: Colors.white),
                                            child: Text(snapshot
                                                        .data!.docs[index]
                                                        .get('finished') ==
                                                    true
                                                ? 'resolved'
                                                    .toString()
                                                    .toUpperCase()
                                                : snapshot.data!.docs[index]
                                                            .get('addressed') ==
                                                        true
                                                    ? 'acknowledged'
                                                        .toString()
                                                        .toUpperCase()
                                                    : 'new'.toString().toUpperCase())),
                                      ],
                                    ),
                                  )),
                              const Divider(
                                height: 15,
                                thickness: 2,
                                indent: 15,
                                endIndent: 15,
                                color: Colors.black45,
                              ),
                            ],
                          );
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
                    padding: EdgeInsets.only(top: 16),
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
            },
          ),
        )
      ],
    );
  }
}
