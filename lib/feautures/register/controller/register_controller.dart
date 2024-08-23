import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/register/model/add_user_model.dart';
import 'package:frontend_ams_mobile_official/feautures/register/repository/add_user_repository.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/navigation.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final StorageService _storage = StorageService();
  final formKey = GlobalKey<FormState>();
  final addUserRepository = getIt.get<AddUserRepository>();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController staffIDController;

  var isFullNameFocused = false.obs;
  var isEmailFocused = false.obs;
  var isPhoneFocused = false.obs;
  var isPasswordFocused = false.obs;
  var isStaffIDFocused = false.obs;
  var selectedRole = ''.obs;

  late FocusNode fullNameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode staffIDFocusNode;

  RxBool isProcessing = false.obs;

  RxString fullNameError = ''.obs;
  RxString emailError = ''.obs;
  RxString phoneError = ''.obs;
  RxString passwordError = ''.obs;
  RxString staffIDError = ''.obs;

  @override
  void onInit() {
    super.onInit();

    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    staffIDController = TextEditingController();

    fullNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    staffIDFocusNode = FocusNode();

    _addFocusListeners();
  }

  void _addFocusListeners() {
    fullNameFocusNode.addListener(() {
      isFullNameFocused.value = fullNameFocusNode.hasFocus;
    });
    emailFocusNode.addListener(() {
      isEmailFocused.value = emailFocusNode.hasFocus;
    });
    phoneFocusNode.addListener(() {
      isPhoneFocused.value = phoneFocusNode.hasFocus;
    });

    staffIDFocusNode.addListener(() {
      isStaffIDFocused.value = staffIDFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    staffIDController.dispose();

    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    staffIDFocusNode.dispose();
    super.onClose();
  }

  String? validateFullName(value) {
    if (value == null || value.isEmpty) {
      fullNameError.value = 'Full name is required';
      return 'Full name is required';
    }
    fullNameError.value = '';
    return null;
  }

  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    emailError.value = '';
    return null;
  }

  String? validatePhone(value) {
    if (value == null || value.isEmpty) {
      phoneError.value = 'Phone is required';
      return 'Phone number is required';
    }
    phoneError.value = '';
    return null;
  }

  String? validateStaffID(value) {
    if (value == null || value.isEmpty) {
      staffIDError.value = 'StaffID is required';
      return 'StaffID is required';
    }
    staffIDError.value = '';
    return null;
  }

  Future<void> addUser() async {
    isProcessing.value = true;

    try {
      var addUserData = AddUserModel(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        staffID: staffIDController.text,
        labRole: selectedRole.value,
      );
      var result = await addUserRepository.addUser(addUserData: addUserData);
      if (result.token != '') {
        isProcessing.value = false;
        await _storage.saveString('token', result.token!);
        await _storage.saveString('fullName', fullNameController.text);
        await _storage.saveString('email', emailController.text);
        await _storage.saveString('phoneNumber', phoneController.text);
        await _storage.saveString(
          'staffID',
          staffIDController.text,
        );
        await _storage.saveString(
          'labRole',
          selectedRole.value.toString(),
        );
        pushReplacement(page: '/Welcome');
      }
    } catch (e) {
      isProcessing.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> validateInputs() async {
    if (formKey.currentState?.validate() ?? false) {
      addUser();
    } else {
      debugPrint('Form is not valid');
    }
  }

  void selectRole(String role) {
    selectedRole.value = role;
  }
}
