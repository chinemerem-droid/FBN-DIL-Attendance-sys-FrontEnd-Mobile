import 'package:frontend_ams_mobile_official/feautures/attendanceHistory/models/userAttendanceHistory.dart';
import 'package:frontend_ams_mobile_official/feautures/attendanceHistory/repository/history_repository.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var attendanceHistoryList = <Userattendancehistory>[].obs;
  var isLoading = false.obs;

  final StorageService _storage = StorageService();
  final userController = getIt.get<HistoryRepository>();

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  void fetchHistory() async {
    String staffId = await _storage.getString('staff_ID');

    isLoading.value = true;
    try {
      final history = await userController.getHistory(
        staffId: staffId,
      );

      attendanceHistoryList.value = history;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
