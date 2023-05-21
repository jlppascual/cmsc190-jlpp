import 'dart:async';

import 'package:alpha_lifeguard/pages/response_unit/full_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/maps_service.dart';
import '../../services/responder_service.dart';
import '../../api/api_key.dart';

// ignore: must_be_immutable
class ReportDetailsPage extends StatefulWidget {
  ReportDetailsPage(
      {super.key,
      required this.desc,
      required this.time,
      required this.finished,
      required this.addressed,
      required this.date,
      required this.rid,
      required this.uid,
      required this.downloadUrl,
      required this.userLoc});

  final dynamic desc;
  final dynamic date;
  final dynamic time;
  final dynamic finished;
  final dynamic uid;
  dynamic addressed;
  final dynamic rid;
  final String downloadUrl;
  final Map<String, dynamic> userLoc;

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage>
    with TickerProviderStateMixin {
  final List<bool> _isDisabled = [false, true];
  final Completer<GoogleMapController> _controller = Completer();
  String profilePicture = '';

  final List<Marker> markers = <Marker>[];

  List<String> userReportName = <String>[];
  String phoneNumber = '';

  List<LatLng> polyLineCoordinates = [];

  Position? currentLocation;

  final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, distanceFilter: 100);

//get points that forms the route from origin to dest
  void getPolyPoints() async {
    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
        PointLatLng(
            markers[1].position.latitude, markers[1].position.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
    setState(() {
      //
    });
  }

//function that listens for the response unit  location change
  void getCurrentLocation() async {
    await MapServices.instance.getUserCurrentLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
      return;
    });
  }

  void getReporterDetails() async {
    dynamic res =
        await ResponderService.instance.getUserReporterDetails(widget.uid);
    setState(() {
      userReportName.add(res['firstName']);
      userReportName.add(res['lastName']);
      phoneNumber = res['phoneNumber'];
      profilePicture = res['imageUrl'];
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
    if (widget.finished == true || widget.addressed == true) {
      setState(() {
        _isDisabled[1] = false;
      });
    }

    markers.add(Marker(
        markerId: const MarkerId('1'),
        position:
            LatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
        infoWindow: const InfoWindow(title: 'Victim Current Location')));

    Future.delayed(Duration.zero, () async {
      await MapServices.instance.getUserCurrentLocation().then((value) async {
        setState(() {
          markers.add(Marker(
              markerId: const MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: 'My Current Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue)));
        });
      });
      getPolyPoints();
    });

    //listens to the change in position
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      GoogleMapController googleMapController = await _controller.future;

      setState(() {
        markers.add(Marker(
            markerId: const MarkerId('2'),
            position: LatLng(position!.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'My Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude))));
      });
    });

    //gets the details of the user the report belongs to
    getReporterDetails();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${widget.downloadUrl}');
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
                      Center(
                          child: GestureDetector(
                              child: SizedBox(
                                  width: 250,
                                  height: 250,
                                  child: Image(
                                    image: widget.downloadUrl == ''
                                        ? const NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/cmsc190-lifeguard.appspot.com/o/reports%2Fdefault.jpg?alt=media&token=ffe3854a-12c1-47a8-bc4d-d9b9e6355c94')
                                        : NetworkImage(widget.downloadUrl),
                                    errorBuilder: (BuildContext context,
                                        Object exception, _) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text('image cannot load'),
                                            Icon(Icons.error_outline_sharp)
                                          ],
                                        ),
                                      );
                                    },
                                  )),
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
                            left: 55, top: 30, bottom: 10, right: 55),
                        child: SizedBox(
                            width: 10,
                            height: 30,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.yellow[100]),
                                onPressed: widget.addressed == false
                                    ? () {
                                        setState(() {
                                          _isDisabled[1] = false;
                                          ResponderService.instance
                                              .addressReport(
                                                  widget.rid.toString());
                                          widget.addressed = true;
                                        });
                                      }
                                    : null,
                                child: const Text('ACKNOWLEDGE'))),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 55, top: 0, bottom: 0, right: 55),
                          child: SizedBox(
                              width: 10,
                              height: 30,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      foregroundColor: Colors.yellow[100]),
                                  onPressed: widget.addressed == false ||
                                          widget.finished == true
                                      ? null
                                      : () {
                                          setState(() {
                                            ResponderService.instance
                                                .finishReport(
                                                    widget.rid.toString());
                                          });
                                        },
                                  child: const Text('FINISHED'))))
                    ],
                  ),
                  ListView(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Center(
                          child: SizedBox(
                              width: 250,
                              height: 250,
                              child:
                                  Image(image: NetworkImage(profilePicture)))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              'NAME: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              userReportName.isEmpty
                                  ? ' '
                                  : '${userReportName[0]} ${userReportName[1]}',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                              'PHONE NUMBER: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                phoneNumber,
                                textAlign: TextAlign.right,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 55, top: 20, bottom: 10, right: 10),
                            child: SizedBox(
                                width: 100,
                                height: 30,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[700],
                                        foregroundColor: Colors.yellow[100]),
                                    onPressed: widget.addressed == false ||
                                            widget.finished == true
                                        ? null
                                        : () {
                                            setState(() {
                                              ResponderService.instance
                                                  .finishReport(
                                                      widget.rid.toString());
                                            });
                                          },
                                    child: const Text('FINISHED'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 20, bottom: 10, right: 55),
                            child: SizedBox(
                                width: 100,
                                height: 30,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[700],
                                        foregroundColor: Colors.yellow[100]),
                                    onPressed: widget.finished == true
                                        ? null
                                        : () {
                                            setState(() {
                                              ResponderService.instance
                                                  .cancelReport(
                                                      widget.rid.toString());
                                            });
                                          },
                                    child: const Text('CANCEL'))),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),
                          SizedBox(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow[800],
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Get.to(() =>
                                      ResponseFullMap(userLoc: widget.userLoc));
                                },
                                child: const Text('SHOW MAP'),
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ));
        }));
  }
}
