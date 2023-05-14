import 'dart:async';

import 'package:alpha_lifeguard/utils/map_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/maps_service.dart';
import '../../services/responder_service.dart';
import 'package:dio/dio.dart';
import '../../api/api_key.dart';

class ReportDetailsPage extends StatefulWidget {
  ReportDetailsPage(
      {super.key,
      required this.desc,
      required this.time,
      required this.finished,
      required this.addressed,
      required this.date,
      required this.rid,
      required this.userLoc});

  final dynamic desc;
  final dynamic date;
  final dynamic time;
  final dynamic finished;
  dynamic addressed;
  final dynamic rid;
  final Map<String, dynamic> userLoc;

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage>
    with TickerProviderStateMixin {
  final List<bool> _isDisabled = [false, true];
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _googleCamPos;

  final List<Marker> markers = <Marker>[];

  List<LatLng> polyLineCoordinates = [];

  Position? currentLocation;

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
    Position? pos;

    pos = await MapServices.instance.getUserCurrentLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
      return;
    });
  }

  @override
  void initState() {
    // TODO: implement setState
    super.initState();

    getCurrentLocation();
    if (widget.finished == true || widget.addressed == true) {
      setState(() {
        _isDisabled[1] = false;
      });
    }

    _googleCamPos = CameraPosition(
        target: LatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
        zoom: MapConstants.defaultCameraZoom,
        tilt: 0,
        bearing: 0);

    markers.add(Marker(
        markerId: const MarkerId('1'),
        position:
            //LatLng(widget.userLoc['latitude'], widget.userLoc['longitude'])
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
                            left: 55, top: 60, bottom: 10, right: 55),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'NAME',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Bae Irene',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                              'PHONE NUMBER',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                '+63 123 456 7890',
                                textAlign: TextAlign.right,
                              )),
                        ],
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: currentLocation == null
                              ? const Text('Loading...')
                              : GoogleMap(
                                  initialCameraPosition: _googleCamPos,
                                  polylines: {
                                    Polyline(
                                        polylineId: PolylineId('route'),
                                        points: polyLineCoordinates,
                                        color: Colors.red,
                                        width: 6)
                                  },
                                  markers: Set<Marker>.of(markers),
                                  mapType: MapType.normal,
                                  myLocationEnabled: true,
                                  compassEnabled: true,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    if (!_controller.isCompleted) {
                                      _controller.complete(controller);
                                    } else {
                                      // do nothing
                                    }
                                  },
                                )),
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
                                    onPressed: () {
                                      debugPrint('finished clicked');
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
                                    onPressed: () {
                                      debugPrint('finished clicked');
                                    },
                                    child: const Text('CANCEL'))),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ));
        }));
  }
}
