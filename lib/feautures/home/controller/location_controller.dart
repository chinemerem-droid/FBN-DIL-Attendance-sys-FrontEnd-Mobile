import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getLocationToUseApp();
    debugPrint('========================================LocationController initialized');
  }

  Future<void> getLocationToUseApp() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      debugPrint(
          '===============================LOCATION CONTROLLER FOR LATITUDE : ${latitude.value}');
      debugPrint(
          '===============================LOCATION CONTROLLER FOR LONGITUDE : ${longitude.value}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool get isInRange {
    return
    //  latitude.value >= 6.5106367 &&
    //     latitude.value <= 6.5107038 &&
    //     longitude.value >= 3.3767505 &&
    //     longitude.value <= 3.3770265;

     latitude.value <= 6.5535388 && longitude.value <= 3.3828311;
  }

  void updateLocation(double lat, double long) {
    latitude.value = lat;
    longitude.value = long;
  }
}
