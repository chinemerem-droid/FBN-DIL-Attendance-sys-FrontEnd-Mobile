import 'package:flutter/material.dart';

const Color primaryColor = Color(0XFF345782);
const Color textFieldColor = Color.fromARGB(255, 244, 241, 241);

const Color primaryColorAccent = Color.fromRGBO(227, 236, 249, 1);

// const Color secondaryColor = Color.fromARGB(255, 255, 255, 255);
const Color secondaryColor = Colors.transparent;

const Color unselectedColor = Color.fromARGB(255, 245, 245, 245);

const Color tertiaryColor = Color.fromARGB(255, 173, 171, 171);



                      // child: PageView.builder(
                      //   onPageChanged: (index) {
                      //     controller.onDaySelected(index);
                      //   },
                      //   controller: controller.pageController.value,
                      //   itemCount: controller.daysInaMonth.length,
                      //   itemBuilder: (context, index) {
                      //     return Obx(
                      //       () => Container(
                      //         decoration: BoxDecoration(
                      //           color: controller.daysInaMonth[index].day ==
                      //                   controller.currentDate.value.day
                      //               ? Colors.blueAccent.withOpacity(.2)
                      //               : Colors.transparent,
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         width: 30,
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               controller.getDayName(
                      //                   controller.daysInaMonth[index]),
                      //               style: const TextStyle(
                      //                 fontSize: 14,
                      //                 color: primaryColor,
                      //               ),
                      //             ),
                      //             Text(
                      //               controller.daysInaMonth[index].day.toString(),
                      //               style: const TextStyle(
                      //                 fontSize: 24,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: primaryColor,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),

