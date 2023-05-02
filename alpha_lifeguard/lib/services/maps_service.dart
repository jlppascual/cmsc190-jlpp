import 'dart:async';
import 'package:alpha_lifeguard/utils/map_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServices extends GetxController {
  static MapServices get instance => Get.find();

  final CollectionReference _reportsCollection =
      FirebaseFirestore.instance.collection('user_reports');

  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _googleCamPos = const CameraPosition(
      target: LatLng(20.42796133580664, 80.885749655962),
      zoom: MapConstants.defaultCameraZoom,
      tilt: 0,
      bearing: 0);

  final List<Marker> markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(title: 'Current Location'))
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR: ${error.toString()}");
    });
    return await Geolocator.getCurrentPosition();
  }

  CameraPosition getCamPos() {
    return _googleCamPos;
  } 

  void updateCamPos(CameraPosition newPos){
    _googleCamPos = newPos;
  }

  List<Marker> getMarker() {
    return markers;
  }

  Completer<GoogleMapController> getCompleter() {
    return _controller;
  }

}
