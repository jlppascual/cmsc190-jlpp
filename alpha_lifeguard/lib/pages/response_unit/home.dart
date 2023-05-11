import 'package:alpha_lifeguard/pages/response_unit/report_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firestore_service.dart';

class ResponseHome extends StatefulWidget {
  const ResponseHome({super.key});

  @override
  State<ResponseHome> createState() => _ResponseHomeState();
}

class _ResponseHomeState extends State<ResponseHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: FirestoreService.instance.getResponderReports(),
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
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
                        itemCount: snapshot.data.length,
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
                                          desc: snapshot.data[index].desc,
                                          time: snapshot.data[index].time,
                                          date:  snapshot.data[index].date,
                                          finished: snapshot.data[index].finished,
                                          addressed: snapshot.data[index].addressed));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text('${snapshot.data[index].date}'),
                                        Text('${snapshot.data[index].type}'),
                                        Text('${snapshot.data[index].time}'),
                                        TextButton(
                                            onPressed: () {
                                              debugPrint('eme');
                                            },
                                            style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                backgroundColor: snapshot
                                                            .data[index]
                                                            .finished ==
                                                        true
                                                    ? Colors.green
                                                    : snapshot.data[index]
                                                                .addressed ==
                                                            true
                                                        ? Colors.yellow[700]
                                                        : Colors.red,
                                                foregroundColor: Colors.white),
                                            child: Text(
                                                snapshot.data[index].finished ==
                                                        true
                                                    ? 'resolved'
                                                    : snapshot.data[index]
                                                                .addressed ==
                                                            true
                                                        ? 'acknowledged'
                                                        : 'new'
                                                            .toString()
                                                            .toUpperCase())),
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
