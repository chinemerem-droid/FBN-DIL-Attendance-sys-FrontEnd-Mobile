import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../login/controller/log_in_controller.dart';

class WelcomeController extends GetxController {
  final LogInController _authController = Get.put(LogInController());
  var currentDate = DateTime.now().obs;
  var currentMonth = DateTime.now().obs;
  var daysInaMonth = <DateTime>[].obs;
  var monthsInYear = <DateTime>[].obs;

  var pageController = PageController(viewportFraction: 0.2).obs;
  var monthController = PageController(initialPage: DateTime.now().month).obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;

  var currentTime = ''.obs;
  Timer? _timer;

  RxString deviceID = ''.obs;
  RxString deviceModel = ''.obs;

  Position? currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String currentAddress = '';

  //===================================================================================================================

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    checkInStatus();
    generateMonthsList();
    getDaysInMonth();
    updateCurrentTime();
    startTimer();
    debugPrint('========================================WelcomeController initailized');
  }

  //===================================================================================================================

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateCurrentTime();
    });
  }

  void updateCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = DateFormat('HH:mm').format(now);
    currentTime.value = formattedDateTime;
  }

  //===================================================================================================================

  void getDaysInMonth() {
    List<DateTime> daysInMonth = [];

    DateTime firstDayOfMonth =
        DateTime(currentDate.value.year, currentDate.value.month, 1);
    DateTime lastDayOfMonth =
        DateTime(currentDate.value.year, currentDate.value.month + 1, 0);

    for (var i = firstDayOfMonth;
        i.isBefore(lastDayOfMonth) || i.isAtSameMomentAs(lastDayOfMonth);
        i = i.add(const Duration(days: 1))) {
      daysInMonth.add(i);
    }

    daysInaMonth.value = daysInMonth;
    debugPrint('days in a month is : $daysInMonth');
  }

  //===================================================================================================================

  void addToMonth() {
    // Increment the month and handle year rollover if necessary
    int month = currentDate.value.month;
    if (month == 12) {
      return;
    }
    month = currentDate.value.month + 1;
    currentDate.value = DateTime(currentDate.value.year, month);
    monthController.value.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    //monthController.value.jumpToPage(currentDate.value.month);
    debugPrint('page is  ${monthController.value.page}');

    getDaysInMonth();
  }

  //===================================================================================================================

  void subtractFromMonth() {
    // Decrement the month and handle year rollover if necessary
    int month = currentDate.value.month;
    if (month == 1) {
      return;
    }

    month = currentDate.value.month - 1;
    currentDate.value = DateTime(currentDate.value.year, month);
    monthController.value.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    debugPrint('page is  ${monthController.value.page}');

    getDaysInMonth();
  }

  void setCurrentMonth(int index) {
    currentDate.value = DateTime(currentDate.value.year, index + 1, 1);
    getDaysInMonth();
  }

  void onDaySelected(int index) {
    currentDate.value =
        DateTime(currentDate.value.year, currentDate.value.month, index + 1);
  }

  //===================================================================================================================

  void generateMonthsList() {
    List<DateTime> monthsList = [];
    for (int month = 1; month <= 12; month++) {
      monthsList.add(DateTime(currentDate.value.year, month));
    }
    monthsInYear.value = monthsList;
    currentMonth.value =
        monthsList.singleWhere((e) => e.month == currentDate.value.month);
    debugPrint("************");

    debugPrint("month ${currentMonth.value}");

    debugPrint("************");
  }

  //===================================================================================================================

  String getDayName(DateTime date) {
    return DateFormat('EE').format(date);
  }

  String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  //===================================================================================================================

  Future<void> getCurrentLocation() async {
    isLoading(true);
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, do something
      isLoading(false);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, do something
        isLoading(false);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, do something
      isLoading(false);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();
    latitude(position.latitude);
    longitude(position.longitude);
    debugPrint('latitude is : ${position.latitude}');
    debugPrint('longitude is : ${position.longitude}');
    isLoading(false);
  }

  //===================================================================================================================

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  //===================================================================================================================

  void checkInStatus() async {
    Position position = await Geolocator.getCurrentPosition();

    debugPrint(
        '=============================DEVICE ID : ${_authController.deviceID}');

    debugPrint(
        '=============================DEVICE MODEL : ${_authController.deviceModel}');

    debugPrint(
        '=============================STAFF ID :${_authController.staff_ID.text} ');

    debugPrint(
        '=============================DEVICE LATITUDE : ${position.latitude.toString()}');

    debugPrint(
        '=============================DEVICE LONGITUDE : ${position.longitude.toString()} ');
  }

  //===================================================================================================================

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
