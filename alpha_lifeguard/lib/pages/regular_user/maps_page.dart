import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import '../../services/maps_service.dart';

class UserMapsPage extends StatefulWidget {
  const UserMapsPage({super.key});

  @override
  State<UserMapsPage> createState() => _UserMapsPageState();
}

class _UserMapsPageState extends State<UserMapsPage> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.yellow[100],
        foregroundColor: Colors.red,
      ),
      body: GoogleMap(
        initialCameraPosition: MapServices.instance.getCamPos(),
        markers: Set<Marker>.of(MapServices.instance.getMarker()),
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
            debugPrint(
                value.latitude.toString() + " " + value.longitude.toString());

            // marker added for current users location
            MapServices.instance.getMarker().add(Marker(
                  markerId: const MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'My Current Location',
                  ),
                ));

              debugPrint(MapServices.instance.getMarker().toString());
            // specified current users location
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller =
                await MapServices.instance.getCompleter().future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(
          Icons.local_activity,
          color: Colors.white,
        ),
      ),
    );
  }
}
