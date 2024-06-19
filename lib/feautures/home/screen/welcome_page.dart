import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ams_mobile_official/feautures/history/controller/history_controller.dart';
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
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 35, right: 35, top: 35, bottom: 0),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // checkOutController.signOut();
                            push(page: '/History');
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  SvgPicture.asset('assets/export-icon.svg')),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEEE dd, yyyy')
                              .format(controller.currentDate.value),
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.06 * 0.7,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            controller.subtractFromMonth();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          child: Obx(() {
                            debugPrint(
                                "MMM  ${controller.currentMonth.value} ");
                            return PageView.builder(
                              controller: controller.monthController.value,
                              itemCount: controller.monthsInYear.length,
                              onPageChanged: (index) {
                                controller.setCurrentMonth(index);
                              },
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(
                                    controller.getMonthName(
                                        controller.monthsInYear[index]),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06 *
                                              1.5,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            controller.addToMonth();
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          controller.onDaySelected(index);
                        },
                        controller: controller.pageController.value,
                        itemCount: controller.daysInaMonth.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: controller.daysInaMonth[index].day ==
                                        controller.currentDate.value.day
                                    ? Colors.blueAccent.withOpacity(.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 30,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.getDayName(
                                        controller.daysInaMonth[index]),
                                    style: const TextStyle(
                                        fontSize: 14, color: primaryColor),
                                  ),
                                  Text(
                                    controller.daysInaMonth[index].day
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(height: 20),
                locationController.isInRange
                    ? SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                InfoBarVerified(
                                    text1: "Location",
                                    text2: 'Digital Innovation Lab'),
                                const SizedBox(height: 10),
                                InfoBar(
                                    text1: "Check in Time",
                                    text2: controller.currentTime.value),
                                const SizedBox(height: 10),
                                InfoBar(text1: "Check Out Time", text2: ''),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SwipeButton(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const InfoWaringBar(
                                text1: "Location",
                                text2: 'Unknown',
                              ),
                              const SizedBox(height: 10),
                              InfoBar(text1: "Check in Time", text2: '---'),
                              const SizedBox(height: 10),
                              InfoBar(text1: "Check Out Time", text2: '---'),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Oops! can’t check you in. Unrecognized Location',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SwipeButtonNonActive(),
                          const SizedBox(height: 20),
                        ],
                      )
              ],
            ),
          )),
    ));
  }
}
