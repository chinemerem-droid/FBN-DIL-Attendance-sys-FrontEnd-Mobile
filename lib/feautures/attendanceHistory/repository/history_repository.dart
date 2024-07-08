import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/attendanceHistory/models/userAttendanceHistory.dart';
import 'package:frontend_ams_mobile_official/feautures/attendanceHistory/service/History_service.dart';
import 'package:get/get.dart';

class HistoryRepository {
  HistoryService historyService;

  HistoryRepository(this.historyService);

  Future<List<Userattendancehistory>> getHistory(
      {required String staffId}) async {
    try {
      final response = await historyService.getUserHistory(staffId: staffId);
      if (response.statusCode == 200) {
        // logInController.isProcessing.isFalse;
        debugPrint(
            '============================================================== HISTORY GOTTEN SUCCESSFULLY !!! =================================================');

        // var data = (response.data);
        // List<Userattendancehistory> historyList =
        //     (data).map<Userattendancehistory>((item) {
        //   return Userattendancehistory.fromJson(item);
        // }).toList();

        // List<dynamic> data = response.data as List<dynamic>;
        // List<Userattendancehistory> historyList =
        //     data.map<Userattendancehistory>((item) {
        //   return Userattendancehistory.fromJson(item as Map<String, dynamic>);
        // }).toList();
        // return historyList;

        if (response.data is List) {
          List<dynamic> data = response.data;
          return data
              .map((item) =>
                  Userattendancehistory.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (response.data is Map<String, dynamic>) {
          // Handle case where response is a single object
          Map<String, dynamic> data = response.data;
          return [Userattendancehistory.fromJson(data)];
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        return [];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 90));
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
