import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_ams_mobile_official/feautures/attendanceHistory/controller/history_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController _controller = Get.put(HistoryController());
  static const String path = '/History';

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.h),
            color: Colors.grey[200],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text('Day'),
                // Text('Check in'),
                // Text('Check out'),
                Column(
                  children: [Text('Day')],
                ),
                Column(
                  children: [Text('Check in')],
                ),
                Column(
                  children: [Text('Check out')],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() {
            if (_controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            if (_controller.attendanceHistoryList.isEmpty) {
              return const Center(
                  child: Text('No attendance history available'));
            }

            return Row(
              children: [
                SizedBox(
                  height: 400.h,
                  width: 300.w,
                  child: ListView.builder(
                    itemCount: _controller.attendanceHistoryList.length,
                    itemBuilder: (context, index) {
                      final item = _controller.attendanceHistoryList[index];
                      return ListTile(
                        title: Text('Staff ID: ${item.staffID}'),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text('Month: ${item.month}'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Date: ${item.date}'),
                                Text('Entry Time: ${item.entryTime}'),
                                Text('Exit Time: ${item.exitTime}'),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          })
        ],
      ),
    );
  }
}
