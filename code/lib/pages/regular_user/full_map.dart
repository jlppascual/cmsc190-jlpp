import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/map_constants.dart';

class UserFullMap extends StatefulWidget {
  const UserFullMap({super.key, required this.userLoc});

  final Map<String, dynamic> userLoc;

  @override
  State<UserFullMap> createState() => _UserFullMapState();
}

class _UserFullMapState extends State<UserFullMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> markers = <Marker>[];
  late CameraPosition _googleCamPos;

  List<LatLng> polyLineCoordinates = [];

  Position? currentLocation;

  final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, distanceFilter: 100);

  @override
  void initState() {
    super.initState();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.yellow[100],
          foregroundColor: Colors.red,
        ),
        body: GoogleMap(
          initialCameraPosition: _googleCamPos,
          
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
