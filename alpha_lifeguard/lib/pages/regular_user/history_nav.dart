import 'package:flutter/material.dart';

class HistoryNav extends StatefulWidget {
  const HistoryNav({super.key});

  @override
  State<HistoryNav> createState() => _HistoryNavState();
}

class _HistoryNavState extends State<HistoryNav> {
  List headers = ['Date', 'Type', 'Time', 'Status'];
  List tempList = [
    {
      'date': 'Dec. 23, 2020',
      'type': 'Medical',
      'time': '4:32 PM',
      'status': 'resolved'
    },
    {
      'date': 'Dec. 29, 2020',
      'type': 'Crime',
      'time': '6:02 PM',
      'status': 'acknowledged'
    },
    {
      'date': 'Dec. 29, 2020',
      'type': 'Rescue',
      'time': '4:32 PM',
      'status': 'new'
    },
  ];
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
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
            child: ListView.builder(
                itemCount: tempList.length + 1,
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
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
                        const Divider(
                          height: 20,
                          thickness: 2,
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black45,
                        )
                      ],
                    );
                  }
                  index -= 1;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(tempList[index]['date']),
                            Text(tempList[index]['type']),
                            Text(tempList[index]['time']),
                            TextButton(
                                onPressed: () {
                                  debugPrint(tempList[index]['status']);
                                },
                                style: TextButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    backgroundColor:
                                        tempList[index]['status'] == 'resolved'
                                            ? Colors.green
                                            : tempList[index]['status'] ==
                                                    'acknowledged'
                                                ? Colors.yellow[700]
                                                : Colors.red,
                                    foregroundColor: Colors.white),
                                child: Text(tempList[index]['status']
                                    .toString()
                                    .toUpperCase())),
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
                  );
                }))
      ],
    );
  }
}
