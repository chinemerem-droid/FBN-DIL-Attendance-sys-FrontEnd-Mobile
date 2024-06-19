import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:get/get.dart';
import '../../../helpers/constants/color.dart';
// import '../../../helpers/functions/navigation.dart';

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
      width: MediaQuery.sizeOf(context).width,
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
    return const Column(
      children: [
        Text(
          'Hello.',
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.w600, fontSize: 50),
        ),
        Text(
          'Lets check you in for the day',
          style: TextStyle(
            color: primaryColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _loginImage() {
    return SvgPicture.asset('assets/welcomeImage.svg');
  }

  Widget _loginTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _loginFormKey,
        child: TextFormField(
          controller: _authController.staff_ID,
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
                : Color.fromARGB(255, 242, 242, 242),
            filled: true,
            focusColor: Colors.white,
            labelText: 'Staff ID',
            // labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(50),
              // Border color when not focused
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
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: () async {
                if (_loginFormKey.currentState?.validate() ?? false) {
                  _authController.authenticateUser();
                } // pushReplacement(page: '/Welcome');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ),
            ),
          );
  }
}
