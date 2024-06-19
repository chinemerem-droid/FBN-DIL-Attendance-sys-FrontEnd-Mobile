import 'package:frontend_ams_mobile_official/feautures/history/model/history_model.dart';
import 'package:get/get.dart';
 
class HistoryController extends GetxController {
  var attendanceRecords = <AttendanceHistoryModel>[].obs;

  void addAttendanceRecord(AttendanceHistoryModel record) {
    attendanceRecords.add(record);
  }

  List<AttendanceHistoryModel> getAttendanceRecords() {
    return attendanceRecords;
  }
}
