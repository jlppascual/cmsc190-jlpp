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

final LocationSettings locationSettings =
    const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0);
GoogleMapController? _controller;

class _ResponseFullMapState extends State<ResponseFullMap> {
  final List<Marker> markers = <Marker>[];
  CameraPosition? _googleCamPos;
  var zoomValue = MapConstants.defaultCameraZoom;
  StreamSubscription<Position>? posStream;

  List<LatLng> polyLineCoordinates = [];

  LatLng? currentLocation;
  Timer? timer;

  //get points that forms the route from origin to dest
  void getPolyPoints() async {
    polyLineCoordinates = [];

    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
        PointLatLng(currentLocation!.latitude, currentLocation!.longitude));

    setState(() {
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) =>
            polyLineCoordinates.add(LatLng(point.latitude, point.longitude)));
      }
    });
  }

//function that listens for the response unit  location change
  void getCurrentLocation() async {
    MapServices.instance.getUserCurrentLocation().then((value) {
      setState(() {
        currentLocation = LatLng(value.latitude, value.longitude);
        getPolyPoints();
        _googleCamPos = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: zoomValue,
        );

        markers.add(Marker(
            markerId: const MarkerId('destination'),
            position:
                LatLng(currentLocation!.latitude, currentLocation!.longitude),
            infoWindow: const InfoWindow(title: 'My Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));
      });
    });

    posStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
 
      setState(() {
        currentLocation = LatLng(position!.latitude, position.longitude);
        getPolyPoints();

        markers.add(Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'My Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));

        // camera position
        _controller?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: zoomValue,
                target: LatLng(position.latitude, position.longitude))));
      });
    });
  }

  @override
  void dispose() {
    posStream?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    markers.add(
      Marker(
          markerId: const MarkerId('source'),
          position:
              LatLng(widget.userLoc['latitude'], widget.userLoc['longitude']),
          infoWindow: const InfoWindow(title: 'Victim Current Location')),
    );

    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.yellow[100],
        foregroundColor: Colors.red,
      ),
      body: _googleCamPos == null
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
              initialCameraPosition: _googleCamPos!,
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
              onCameraMove: (CameraPosition cameraPos) async {
                setState(() {
                  zoomValue = cameraPos.zoom;
                });
              },
              onMapCreated: (GoogleMapController controller) {
                // if (!_controller.isCompleted) {
                  _controller=controller;
                // } else {
                //   //
                // }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          MapServices.instance.getUserCurrentLocation().then((value) async {
            // specified current users location
            CameraPosition newCameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: zoomValue,
                bearing: 0,
                tilt: 0);
            _controller?.animateCamera(
                CameraUpdate.newCameraPosition(newCameraPosition));
            setState(() {
              _googleCamPos = newCameraPosition;

              // marker added for current users location
              currentLocation = LatLng(value.latitude, value.longitude);
              getPolyPoints();
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
