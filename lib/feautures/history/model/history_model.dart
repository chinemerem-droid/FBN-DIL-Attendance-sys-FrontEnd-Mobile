import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';

class AttendanceHistoryModel {
  String staffID;
  String entryTime;
  String exitTime;
  DateTime date;
  int month;
  int year;

  AttendanceHistoryModel({
    required this.staffID,
    required this.entryTime,
    required this.exitTime,
    required this.date,
    required this.month,
    required this.year,
  });

  factory AttendanceHistoryModel.fromJson(DynamicMap json) {
    return AttendanceHistoryModel(
      staffID: json['staff_ID'],
      entryTime: json['entryTime'],
      exitTime: json['exitTime'],
      date: DateTime.parse(json['date']),
      month: json['month'],
      year: json['year'],
    );
  }

  DynamicMap toJson() {
    return {
      'staff_ID': staffID,
      'entryTime': entryTime,
      'exitTime': exitTime,
      'date': date.toIso8601String(),
      'month': month,
      'year': year,
    };
  }
}
