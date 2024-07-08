import 'package:frontend_ams_mobile_official/feautures/attendanceHistory/screen/history_page.dart';
 import 'package:frontend_ams_mobile_official/feautures/home/screen/welcome_page.dart';
import 'package:frontend_ams_mobile_official/feautures/login/screen/login_page.dart';
import 'package:get/get.dart';

import '../../feautures/wrapper/wrapper_screen.dart';

class AppPages {
  static List<GetPage> appPages = [
    GetPage(
      name: WrapperScreen.path,
      page: () => WrapperScreen(),
    ),
    GetPage(
      name: LoginPage.path,
      page: () => LoginPage(),
    ),
    GetPage(
      name: WelcomePage.path,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: HistoryPage.path,
      page: () => HistoryPage(),
    ),
  ];
}
