import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ams_mobile_official/feautures/register/controller/register_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const path = '/Register';
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/Vector.svg',
          width: 10.w,
          height: 10.h,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 5.h),
            child: Form(
              key: registerController.formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 50.sp),
                      ),
                      Text(
                        'Lets check you in for the day',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Obx(() => TextFormField(
                        controller: registerController.fullNameController,
                        focusNode: registerController.fullNameFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          labelText: 'Full Name',
                          filled: true,
                          fillColor: registerController.isFullNameFocused.value
                              ? Colors.transparent
                              : unselectedColor,
                          errorText:
                              registerController.fullNameError.value.isNotEmpty
                                  ? registerController.fullNameError.value
                                  : null,
                        ),
                        onChanged: (value) =>
                            registerController.validateFullName(value),
                        validator: (value) =>
                            registerController.validateFullName(value),
                      )),
                  SizedBox(height: 20.h),
                  Obx(() => TextFormField(
                        controller: registerController.emailController,
                        focusNode: registerController.emailFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          labelText: 'Email',
                          filled: true,
                          fillColor: registerController.isEmailFocused.value
                              ? Colors.transparent
                              : unselectedColor,
                          errorText:
                              registerController.emailError.value.isNotEmpty
                                  ? registerController.emailError.value
                                  : null,
                        ),
                        onChanged: (value) =>
                            registerController.validateEmail(value),
                        validator: (value) =>
                            registerController.validateEmail(value),
                      )),
                  const SizedBox(height: 20),
                  Obx(() => TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: registerController.phoneController,
                        focusNode: registerController.phoneFocusNode,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            labelText: 'Phone Number',
                            filled: true,
                            fillColor: registerController.isPhoneFocused.value
                                ? Colors.transparent
                                : unselectedColor,
                            errorText:
                                registerController.phoneError.value.isNotEmpty
                                    ? registerController.phoneError.value
                                    : null),
                        onChanged: (value) {
                          registerController.phoneError.value = '';
                        },
                        validator: (value) =>
                            registerController.validatePhone(value),
                      )),
                  SizedBox(height: 20.h),
                  Obx(() => TextFormField(
                        controller: registerController.staffIDController,
                        focusNode: registerController.staffIDFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          labelText: 'Staff ID',
                          filled: true,
                          fillColor: registerController.isStaffIDFocused.value
                              ? Colors.transparent
                              : unselectedColor,
                          errorText:
                              registerController.staffIDError.value.isNotEmpty
                                  ? registerController.staffIDError.value
                                  : null,
                        ),
                        onChanged: (value) =>
                            registerController.validateStaffID(value),
                        validator: (value) =>
                            registerController.validateStaffID(value),
                        obscureText: true,
                      )),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => Row(
                            children: [
                              Radio<String>(
                                value: 'Sub Admin',
                                groupValue:
                                    registerController.selectedRole.value,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    registerController.selectRole(value);
                                  }
                                },
                              ),
                              const Text('Sub Admin'),
                            ],
                          )),
                      Obx(() => Row(
                            children: [
                              Radio<String>(
                                value: 'Super Admin',
                                groupValue:
                                    registerController.selectedRole.value,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    registerController.selectRole(value);
                                  }
                                },
                              ),
                              const Text('Super Admin'),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  registerController.isProcessing.isTrue
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            registerController.validateInputs();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(100.r)),
                            child: Padding(
                              padding: EdgeInsets.all(15.h),
                              child: Center(
                                child: Text('Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp)),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            )),
      ),
    );
  }
}
