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
    debugPrint(
        '========================================LocationController initialized');
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
    return latitude.value >= 6.4106360 &&
        latitude.value <= 6.6107040 &&
        longitude.value >= 3.3667500 &&
        longitude.value <= 3.3870265;

    //  latitude.value <= 7.5535388 && longitude.value <= 4.3828311;
    //  latitude.value <=  6.5535858 && longitude.value <=  6.5535568;
  }

  void updateLocation(double lat, double long) {
    latitude.value = lat;
    longitude.value = long;
  }
}
