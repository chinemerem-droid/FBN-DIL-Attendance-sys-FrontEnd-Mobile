import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helpers/constants/color.dart';

class LoginPage extends StatelessWidget {
  static const String path = '/Login';

  LoginPage({super.key});
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  final LogInController _authController = Get.find<LogInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildUI(context: context)),
    );
  }

  Widget _buildUI({required BuildContext context}) {
    return SizedBox(
      width: 1.sw, // Screen width
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _loginWelcomeText(),
            _loginImage(),
            _loginTextField(),
            Obx(() {
              return _loginButton();
            })
          ]),
    );
  }

  Widget _loginWelcomeText() {
    return Column(
      children: [
        Text(
          'Hello.',
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.w600, fontSize: 50.sp),
        ),
        Text(
          'Lets check you in for the day',
          style: TextStyle(
            color: primaryColor,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }

  Widget _loginImage() {
    return SvgPicture.asset(
      'assets/welcomeImage.svg',
      width: 200.w,
      height: 200.h,
    );
  }

  Widget _loginTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
        key: _loginFormKey,
        child: TextFormField(
          controller: _authController.staffID,
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter a Staff ID';
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: _authController.isFocused.isTrue
                ? Colors.white
                : const Color.fromARGB(255, 242, 242, 242),
            filled: true,
            focusColor: Colors.white,
            labelText: 'Staff ID',
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          onTap: () {
            _authController.isFocused.value = true;
          },
          onFieldSubmitted: (event) {
            _authController.isFocused.value = false;
          },
        ),
      ),
    );
  }

  Widget _loginButton() {
    debugPrint(" #####**** processing ${_authController.isProcessing.isTrue} ");

    return _authController.isProcessing.isTrue
        ? const CircularProgressIndicator()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: GestureDetector(
              onTap: () async {
                if (_loginFormKey.currentState?.validate() ?? false) {
                  _authController.authenticateUser();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(100.r)),
                child: Padding(
                  padding: EdgeInsets.all(15.h),
                  child: Center(
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                  ),
                ),
              ),
            ),
          );
  }
}
