import 'package:flutter/material.dart';

class HistoryBuilder extends StatefulWidget {
  const HistoryBuilder({super.key});

  @override
  State<HistoryBuilder> createState() => _HistoryBuilderState();
}

class _HistoryBuilderState extends State<HistoryBuilder> {
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
    return ListView.builder(
        itemCount: tempList.length,
        itemBuilder: (context, int index) {
          return Row(
            children: [
              Column(
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
              )
            ],
          );
        });
  }
}
