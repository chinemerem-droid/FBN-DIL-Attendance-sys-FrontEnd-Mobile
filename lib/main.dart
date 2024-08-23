import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_ams_mobile_official/feautures/wrapper/wrapper_screen.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';
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
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "frontend ams mobile official",
        home: WrapperScreen(),
        initialRoute: WrapperScreen.path,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
            primaryColor: primaryColor,
             appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor, // Primary color for app bar, buttons, etc.
         )),
            
        smartManagement: SmartManagement.keepFactory,
        getPages: AppPages.appPages,
      ),
    );
  }
}
