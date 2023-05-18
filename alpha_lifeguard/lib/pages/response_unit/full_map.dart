import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../api/api_key.dart';
import '../../services/maps_service.dart';
import '../../utils/map_constants.dart';

class ResponseFullMap extends StatefulWidget {
  const ResponseFullMap({super.key, required this.userLoc});

  final Map<String, dynamic> userLoc;

  @override
  State<ResponseFullMap> createState() => _ResponseFullMapState();
}

class _ResponseFullMapState extends State<ResponseFullMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> markers = <Marker>[];
  late CameraPosition _googleCamPos;

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

  @override
  void initState() {
    // TODO: implement setState
    super.initState();

    getCurrentLocation();

    _googleCamPos = CameraPosition(
        target: LatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
        zoom: MapConstants.defaultCameraZoom,
        tilt: 0,
        bearing: 0);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.yellow[100],
          foregroundColor: Colors.red,
        ),
        body: currentLocation == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Loading Map...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : GoogleMap(
                initialCameraPosition: _googleCamPos,
                polylines: {
                  Polyline(
                      polylineId: const PolylineId('route'),
                      points: polyLineCoordinates,
                      color: Colors.red,
                      width: 6)
                },
                markers: Set<Marker>.of(markers),
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  } else {
                    // do nothing
                  }
                },
              ));
  }
}
