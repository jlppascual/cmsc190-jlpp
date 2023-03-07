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
      'date': 'December 23, 2020',
      'type': 'Medical',
      'time': '4:32 PM',
      'status': 'resolved'
    },
    {
      'date': 'December 29, 2020',
      'type': 'Crime',
      'time': '6:02 PM',
      'status': 'acknowledged'
    },
    {
      'date': 'December 29, 2020',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: const [
                Text('History', textAlign: TextAlign.left,),
                Text('Details of reports you sent so far'),
              ],
            )
          ],
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
                            Text('Date'),
                            Text('Type'),
                            Text('Time'),
                            Text('Status')
                          ],
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
                                child: Text(tempList[index]['status']))
                          ],
                        ),
                      )
                    ],
                  );
                }))
      ],
    );
  }
}
