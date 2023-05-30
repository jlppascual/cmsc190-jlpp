import 'dart:async';
import 'package:alpha_lifeguard/pages/regular_user/full_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/user_service.dart';

// ignore: must_be_immutable
class UserReportDetailsPage extends StatefulWidget {
  UserReportDetailsPage(
      {super.key,
      required this.desc,
      required this.finished,
      required this.addressed,
      required this.dateTime,
      required this.rid,
      required this.uid,
      required this.userLoc,
      required this.downloadUrl,
      required this.address});

  final dynamic desc;
  final dynamic dateTime;
  final dynamic finished;
  dynamic addressed;
  final dynamic rid;
  final dynamic uid;
  final Map<String, dynamic> userLoc;
  final String downloadUrl;
  final String address;

  @override
  State<UserReportDetailsPage> createState() => _UserReportDetailsPageState();
}

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

class _UserReportDetailsPageState extends State<UserReportDetailsPage>
    with TickerProviderStateMixin {
  final List<Marker> markers = <Marker>[];
  List<LatLng> polyLineCoordinates = [];

  var ref;

  String? profilePicture;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Position? currentLocation;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Map<String, dynamic> data =
          await UserServices.instance.getUserMapDetails();

      setState(() {
        markers.add(Marker(
            markerId: const MarkerId('1'),
            position:
                LatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
            infoWindow: const InfoWindow(title: 'Victim Current Location')));
        profilePicture = data['imageUrl'];
        firstName = data['firstName'];
        lastName = data['lastName'];
        phoneNumber = data['phoneNumber'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context) {
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
                      Center(
                          child: GestureDetector(
                              child: SizedBox(
                                  width: 250,
                                  height: 250,
                                  child: Image(
                                      image: widget.downloadUrl == ''
                                          ? const NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/cmsc190-lifeguard.appspot.com/o/reports%2Fdefault.jpg?alt=media&token=ffe3854a-12c1-47a8-bc4d-d9b9e6355c94')
                                          : NetworkImage(widget.downloadUrl))),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          widget.downloadUrl),
                                                      fit: BoxFit.contain))));
                                    });
                              })),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                          'REPORT ADDRESS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: widget.address.toString() == ''
                            ? const Text('no location saved')
                            : Text(widget.address.toString()),
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
                        child: widget.desc.toString() == ''
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
                                Text(
                                    '${months[widget.dateTime.toDate().month - 1]}. ${widget.dateTime.toDate().day}, ${widget.dateTime.toDate().year}')
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
                                Text(
                                    '${widget.dateTime.toDate().hour > 12 ? widget.dateTime.toDate().hour - 12 : widget.dateTime.toDate().hour}:${widget.dateTime.toDate().minute.bitLength < 2 ? "0${widget.dateTime.toDate().minute}" : widget.dateTime.toDate().minute} ${widget.dateTime.toDate().hour > 12 ? "PM" : "AM"}'),
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
                    ],
                  ),
                  ListView(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Center(
                          child: SizedBox(
                              width: 250,
                              height: 250,
                              child: Image(
                                  image: profilePicture == '' ||
                                          profilePicture == null
                                      ? const NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/cmsc190-lifeguard.appspot.com/o/reports%2Fdefault.jpg?alt=media&token=ffe3854a-12c1-47a8-bc4d-d9b9e6355c94')
                                      : NetworkImage(profilePicture!)))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              'NAME: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              '${firstName} ${lastName}',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                              'PHONE NUMBER:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                '+63$phoneNumber',
                                textAlign: TextAlign.right,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                                width: 200,
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[700],
                                      foregroundColor: Colors.yellow[100]),
                                  onPressed: () {
                                    Get.to(() =>
                                        UserFullMap(userLoc: widget.userLoc));
                                  },
                                  child: const Text('SHOW MAP'),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ));
        }));
  }
}
