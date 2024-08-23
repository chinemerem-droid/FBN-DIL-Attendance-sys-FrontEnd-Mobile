import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_out_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/welcome_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/navigation.dart';
import 'package:frontend_ams_mobile_official/helpers/widgets/info_bar_verified.dart';
import 'package:frontend_ams_mobile_official/helpers/widgets/info_warning_bar.dart';
import 'package:frontend_ams_mobile_official/helpers/widgets/swipe_button_non_active.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/widgets/swipe_buttoton.dart';
import '../../../helpers/constants/color.dart';
import '../../../helpers/widgets/info_bar.dart';
import '../controller/location_controller.dart';

class WelcomePage extends StatelessWidget {
  static const String path = '/Welcome';
  WelcomePage({super.key});
  final WelcomeController controller = Get.put(WelcomeController());
  final LogInController logincontroller = Get.put(LogInController());
  final CheckOutController checkOutController = Get.put(CheckOutController());
  final CheckInController checkInController = Get.put(CheckInController());
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 10.h,
            ),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.getGreeting(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            fontSize: 21.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // (page: '/History');
                            // checkOutController.signOut();
                            push(page: '/History');
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child:
                                  SvgPicture.asset('assets/export-icon.svg')),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEEE dd, yyyy')
                              .format(controller.currentDate.value),
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.subtractFromMonth();
                          },
                          child: SvgPicture.asset('assets/backwardIcon.svg'),
                        ),
                        SizedBox(
                          width: 150.w,
                          height: 100.h,
                          child: Obx(() {
                            debugPrint(
                                "MMM  ${controller.currentMonth.value} ");
                            return PageView.builder(
                              controller: controller.monthController.value,
                              itemCount: controller.monthsInYear.length,
                              onPageChanged: (index) {
                                controller.setCurrentMonth();
                              },
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(
                                    controller.getMonthName(
                                        controller.monthsInYear[index]),
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.addToMonth();
                          },
                          child: SvgPicture.asset('assets/forwardIcon.svg'),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 100.h,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          controller.onDaySelected(index);
                        },
                        controller: controller.pageController.value,
                        itemCount: controller.daysInaMonth.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                color: controller.daysInaMonth[index].day ==
                                        controller.currentDate.value.day
                                    ? primaryColorAccent
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              width: 50.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.getDayName(
                                        controller.daysInaMonth[index]),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: controller
                                                    .daysInaMonth[index].day ==
                                                controller.currentDate.value.day
                                            ? primaryColor
                                            : unselectedColor),
                                  ),
                                  Text(
                                    controller.daysInaMonth[index].day
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: controller
                                                  .daysInaMonth[index].day ==
                                              controller.currentDate.value.day
                                          ? primaryColor
                                          : unselectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Divider(),
                SizedBox(height: 20.h),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          locationController.isInRange
                              ? const InfoBarVerified(
                                  text1: "Location",
                                  text2: 'Digital Innovation Lab',
                                )
                              : const InfoWaringBar(
                                  text1: 'Location', text2: 'Unknown'),
                          SizedBox(height: 10.h),
                          Obx(
                            () => InfoBar(
                                text1: "Check in Time",
                                text2: locationController.isInRange
                                    ? checkInController.checkInTime.value
                                    : '---'),
                          ),
                          SizedBox(height: 10.h),
                          InfoBar(
                              text1: "Check Out Time",
                              text2: locationController.isInRange
                                  ? checkOutController.checkOutTime.value
                                  : '---'),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      locationController.isInRange
                          ? const Text(
                              '',
                            )
                          : const Center(
                              child: Text(
                                'Oops! can’t check you in. Unrecognized Location',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                      SizedBox(
                        height: 5.h,
                      ),
                      locationController.isInRange
                          ? SwipeButton()
                          : const SwipeButtonNonActive(),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
