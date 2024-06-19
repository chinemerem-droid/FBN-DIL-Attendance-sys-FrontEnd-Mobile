import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_ams_mobile_official/feautures/wrapper/wrapper_screen.dart';
import 'package:get/get.dart';
import 'helpers/functions/api_service_locator.dart';
import 'helpers/functions/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init(); not really needed
  await dotenv.load(fileName: ".env");
  await apiServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "frontend ams mobile official",
      home: WrapperScreen(),
      // color: primaryColor,
      // themeMode: ThemeMode.system,
      initialRoute: WrapperScreen.path,
      smartManagement: SmartManagement.keepFactory,
      getPages: AppPages.appPages,
    );
  }
}
