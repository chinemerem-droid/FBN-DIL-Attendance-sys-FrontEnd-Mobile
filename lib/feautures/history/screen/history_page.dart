import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/history/controller/history_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/history/model/history_model.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  static const String path = '/History';

  final HistoryController controller = Get.find();

  HistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance History'),
      ),
      body: Obx(() {
        List<AttendanceHistoryModel> records =
            controller.getAttendanceRecords();

        return ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            AttendanceHistoryModel record = records[index];
            return ListTile(
              title: Text('Staff ID: ${record.staffID}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${record.date.toLocal()}'),
                  Text('Entry Time: ${record.entryTime}'),
                  Text('Exit Time: ${record.exitTime}'),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
