import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapServices extends GetxController {
  static MapServices get instance => Get.find();

  final bool myLocationEnabled = false;

  Future<bool> isGetCurrLocationEnabled() async {
    var permission = await Geolocator.checkPermission();

    if (permission.toString() == 'LocationPermission.always' ||
        permission.toString() == 'LocationPermission.whileInUse') {
      return true;
    } else {
      return false;
    }
  }

  void requestCurrLocationAccess() async {
    var res = await isGetCurrLocationEnabled();
    if (res == true) {
      // do nothing
    } else {
      await Geolocator.requestPermission();
    }
  }

  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request to get current location');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
  }
}
