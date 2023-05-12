import 'package:flutter/material.dart';

import '../../services/responder_service.dart';

class ReportDetailsPage extends StatefulWidget {
  ReportDetailsPage(
      {super.key,
      required this.desc,
      required this.time,
      required this.finished,
      required this.addressed,
      required this.date,
      required this.rid});

  final dynamic desc;
  final dynamic date;
  final dynamic time;
  final dynamic finished;
  final dynamic addressed;
  final dynamic rid;

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage>
    with TickerProviderStateMixin {
  final List<bool> _isDisabled = [false, true];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if (widget.finished == true || widget.addressed == true) {
      setState(() {
        _isDisabled[1] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (_isDisabled[tabController.index] == true) {
              tabController.index = tabController.previousIndex;
            } else if (_isDisabled[tabController.index] == false) {}
          });
          return Scaffold(
              appBar: AppBar(
                title: const Text('REPORT DETAILS'),
                bottom: const TabBar(
                  
                  tabs: <Widget>[
                    Tab(child: Text('REPORT DETAILS')),
                    Tab(child: Text('PERSONAL DETAILS'))
                  ],
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    children: <Widget>[
                      const Center(
                          child: SizedBox(
                              width: 250,
                              height: 250,
                              child: Image(
                                  image: NetworkImage(
                                      'https://i.pinimg.com/originals/09/b3/34/09b334fd23b9be6a472a2f3eada61759.jpg')))),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'REPORT LOCATION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Blk A Lot B 2-3th St. Subdivision Manila City, 1080',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                          'REPORT DESCRIPTION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: widget.desc.toString() == 'null'
                            ? const Text('no description written')
                            : Text(widget.desc.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('REPORT SENT ON: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(widget.date)
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('REPORT SENT AT: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(widget.time)
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('STATUS: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                widget.finished == true
                                    ? Text(
                                        'RESOLVED',
                                        style:
                                            TextStyle(color: Colors.green[700]),
                                      )
                                    : widget.addressed == true
                                        ? Text(
                                            'ACKNOWLEDGED',
                                            style: TextStyle(
                                                color: Colors.yellow[700]),
                                          )
                                        : Text(
                                            'NEW',
                                            style: TextStyle(
                                                color: Colors.red[700]),
                                          )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 55, top: 10, bottom: 10, right: 55),
                        child: SizedBox(
                            width: 10,
                            height: 30,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.yellow[100]),
                                onPressed: () {
                                  setState(() {
                                    _isDisabled[1] = false;
                                    ResponderService.instance
                                        .addressReport(widget.rid.toString());
                                  });
                                },
                                child: const Text('ACKNOWLEDGE'))),
                      ),
                    ],
                  ),
                  ListView(
                    children: <Widget>[
                      const Center(
                          child: SizedBox(
                              width: 250,
                              height: 250,
                              child: Image(
                                  image: NetworkImage(
                                      'https://i.pinimg.com/originals/09/b3/34/09b334fd23b9be6a472a2f3eada61759.jpg')))),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'REPORT LOCATION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Blk A Lot B 2-3th St. Subdivision Manila City, 1080',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                          'REPORT DESCRIPTION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: widget.desc.toString() == 'null'
                            ? const Text('no description written')
                            : Text(widget.desc.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('REPORT SENT ON: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(widget.date)
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('REPORT SENT AT: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(widget.time)
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('STATUS: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                widget.finished == true
                                    ? Text(
                                        'RESOLVED',
                                        style:
                                            TextStyle(color: Colors.green[700]),
                                      )
                                    : widget.addressed == true
                                        ? Text(
                                            'ACKNOWLEDGED',
                                            style: TextStyle(
                                                color: Colors.yellow[700]),
                                          )
                                        : Text(
                                            'NEW',
                                            style: TextStyle(
                                                color: Colors.red[700]),
                                          )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 55, top: 10, bottom: 10, right: 55),
                        child: SizedBox(
                            width: 10,
                            height: 30,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.yellow[100]),
                                onPressed: () {
                                  setState(() {
                                    _isDisabled[1] = false;
                                  });
                                },
                                child: const Text('ACKNOWLEDGE'))),
                      ),
                    ],
                  ),
                ],
              ));
        }));
  }
}
