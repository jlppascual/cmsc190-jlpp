import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import '../../services/maps_service.dart';
import '../../utils/map_constants.dart';

class UserMapsPage extends StatefulWidget {
  UserMapsPage({super.key, required this.currLocation});

  Map<String, dynamic> currLocation;

  @override
  State<UserMapsPage> createState() => _UserMapsPageState();
}

class _UserMapsPageState extends State<UserMapsPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _googleCamPos = const CameraPosition(
      target: LatLng(14.3875, 121.0463),
      zoom: MapConstants.defaultCameraZoom,
      tilt: 0,
      bearing: 0);

  final List<Marker> markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(14.3875, 121.0463),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Current Location'))
  ];

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
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          MapServices.instance.getUserCurrentLocation().then((value) async {
            // specified current users location
            CameraPosition newCameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
                bearing: 0,
                tilt: 0);
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(newCameraPosition));
            setState(() {
              _googleCamPos = newCameraPosition;
              widget.currLocation = <String, dynamic>{
                'latitude': value.latitude,
                'longitude': value.longitude
              };

              // marker added for current users location
              markers.add(Marker(
                markerId: const MarkerId("1"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: 'My Current Location',
                ),
              ));

              debugPrint(widget.currLocation.toString());
            });
          });
        },
        child: const Icon(
          Icons.pin_drop_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
