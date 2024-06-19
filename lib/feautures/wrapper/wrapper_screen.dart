import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/wrapper/controller.dart';
import 'package:get/get.dart';

class WrapperScreen extends StatelessWidget {
  static const String path = '/';

  final WrapperController ctrl = Get.put(WrapperController());

  WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
