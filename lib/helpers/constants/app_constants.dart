enum RequestMethod { post, get, delete, put, patch }

typedef DynamicMap = Map<String, dynamic>;
  

//   class WelcomePage extends StatefulWidget {
//   static const String path = '/Welcome';
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   DateTime? currentDate;
//   DateTime? currentMonth;

//   // final int _currentMonth = DateTime.now().month;
//   LogInController logInController = Get.put(LogInController());

//   List<DateTime> daysInaMonth = [];
//   List<DateTime> monthsInYear = [];

//   PageController? pageController;
//   final PageController monthController = PageController(initialPage: 0);

//   getDaysInMonth() {
//     List<DateTime> _daysInMonth = [];

//     // Calculate the first day of the month
//     DateTime firstDayOfMonth =
//         DateTime(currentDate!.year, currentDate!.month, 1);

//     // Calculate the last day of the month
//     DateTime lastDayOfMonth =
//         DateTime(currentDate!.year, currentDate!.month + 1, 0);

//     // Loop through each day in the month and add them to the list
//     for (var i = firstDayOfMonth;
//         i.isBefore(lastDayOfMonth) || i.isAtSameMomentAs(lastDayOfMonth);
//         i = i.add(const Duration(days: 1))) {
//       _daysInMonth.add(i);
//     }

//     daysInaMonth = _daysInMonth;

//     debugPrint("day lenght is ${daysInaMonth.length}");

//     setState(() {});
//   }

//   addToMonth() {
//     currentDate = DateTime(currentDate!.month + 1);
//     setState(() {});
//     debugPrint("add to month is ${currentDate!.month}");
//   }

// //========================================this needs attention*

//   void _onDaySelected(int index) {
//     setState(() {
//       currentDate = DateTime(currentDate!.year, currentDate!.month, index + 1);
//     });
//   }
// //================================================

//   generateMonthsList() {
//     List<DateTime> monthsList = [];
//     for (int month = 1; month <= 12; month++) {
//       monthsList.add(DateTime(currentDate!.year, month));
//       monthsInYear = monthsList;
//     }
//     debugPrint("month is $monthsInYear");
//     currentMonth = monthsList.singleWhere(
//         (e) => e == DateTime(currentDate!.year, currentDate!.month));
//     setState(() {});
//   }

//   int currentIndex = DateTime.now().month - 1;

//   @override
//   void initState() {
//     currentDate = DateTime.now();
//     currentMonth = DateTime.now();
//     generateMonthsList();
//     pageController = PageController(viewportFraction: 0.2);
//     getDaysInMonth();
//     super.initState();
//   }

//   String getDayName(DateTime date) {
//     return DateFormat('EE').format(date);
//   }

//   String getMonthName(DateTime date) {
//     final monthsDisplayed = DateFormat('MMMM').format(date);
//     return monthsDisplayed;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryData = MediaQuery.of(context);
//     final screenWidth = mediaQueryData.size.width;
//     final screenHeight = mediaQueryData.size.height;
//     double fontSize = screenWidth * 0.06; // Adjust multiplier as needed

//     // Define the desired format
//     DateFormat dateFormat = DateFormat('EEEE dd, yyyy');

//     // Format the date
//     String formattedDate = dateFormat.format(currentDate!);

//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Welcome back,',
//                         style: TextStyle(
//                           fontSize: fontSize,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         'Michael',
//                         style: TextStyle(
//                             fontSize: fontSize,
//                             color: primaryColor,
//                             fontWeight: FontWeight.w600),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             formattedDate,
//                             style: TextStyle(
//                                 fontSize: 0.7 * fontSize, color: primaryColor),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           FloatingActionButton(
//                             backgroundColor: Colors.white,
//                             onPressed: () {
//                               monthController.previousPage(
//                                   duration: const Duration(
//                                     milliseconds: 600,
//                                   ),
//                                   curve: Curves.ease);
//                               setState(() {
//                                 currentMonth = DateTime(currentDate!.year,
//                                     currentDate!.month - 1, currentDate!.day);
//                                 currentDate = DateTime(currentDate!.year,
//                                     currentDate!.month - 1, currentDate!.day);
//                               });
//                               debugPrint("${currentDate!.month}");
//                               setState(() {});
//                               getDaysInMonth();
//                             },
//                             child: const Icon(
//                               Icons.arrow_back_ios,
//                               color: primaryColor,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 200,
//                             height: 100,
//                             child: PageView.builder(
//                               // onPageChanged: _onMonthSelected,
//                               controller: monthController,
//                               itemCount: monthsInYear.length,
//                               itemBuilder: (context, index) {
//                                 return Center(
//                                     child: Text(
//                                   getMonthName(currentMonth!),
//                                   style: TextStyle(
//                                       fontSize: 1.5 * fontSize,
//                                       color: primaryColor,
//                                       fontWeight: FontWeight.w600),
//                                 ));
//                               },
//                             ),
//                           ),
//                           FloatingActionButton(
//                             backgroundColor: Colors.white,
//                             onPressed: () {
//                               monthController.nextPage(
//                                   duration: const Duration(
//                                     milliseconds: 600,
//                                   ),
//                                   curve: Curves.ease);

//                               setState(() {
//                                 currentMonth = DateTime(currentDate!.year,
//                                     currentDate!.month + 1, currentDate!.day);
//                                 currentDate = DateTime(currentDate!.year,
//                                     currentDate!.month + 1, currentDate!.day);
//                               });

//                               debugPrint(
//                                   "month is @@@@@@ ${currentDate!.month}");

//                               getDaysInMonth();
//                             },
//                             child: const Icon(
//                               Icons.arrow_forward_ios,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         height: 100,
//                         child: PageView.builder(
//                           onPageChanged: _onDaySelected,
//                           controller: pageController,
//                           itemCount: daysInaMonth.length,
//                           itemBuilder: (context, index) {
//                             return SizedBox(
//                               width: 30,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: daysInaMonth
//                                                 .indexOf(daysInaMonth[index]) ==
//                                             pageController!.page?.round()
//                                         ? Colors.blueAccent.withOpacity(.2)
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: 60,
//                                 width: 17,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       getDayName(daysInaMonth[index]),
//                                       style: const TextStyle(
//                                           fontSize: 14, color: primaryColor),
//                                     ),
//                                     Text(
//                                       daysInaMonth[index].day.toString(),
//                                       style: const TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w700,
//                                           color: primaryColor),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               SizedBox(
//                 height: 0.4 * screenHeight,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         InfoBar(
//                             text1: "Location", text2: 'Digital Innovation Lab'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         InfoBar(text1: "Check in Time", text2: '9:44am'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         InfoBar(text1: "Check Out Time", text2: ''),
//                       ],
//                     ),
//                     SwipeButton(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:frontend_ams_mobile_official/feautures/home_page/controller/home_controller.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../utils/constants/color.dart'; // Assuming this is where your color constants are defined
// import '../../utils/Components/info_bar.dart';
// import '../../utils/Components/swipe_buttoton.dart'; // Assuming these are custom components

// class WelcomePage extends StatefulWidget {
//   static const String path = '/Welcome';
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   final controller = Get.put(HomeController());

//   String getDayName(DateTime date) {
//     return DateFormat('EE').format(date);
//   }

//   String getMonthName(DateTime date) {
//     final monthsDisplayed = DateFormat('MMMM').format(date);
//     return monthsDisplayed;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryData = MediaQuery.of(context);
//     final screenWidth = mediaQueryData.size.width;
//     final screenHeight = mediaQueryData.size.height;
//     double fontSize = screenWidth * 0.06; // Adjust multiplier as needed

//     DateFormat dateFormat = DateFormat('EEEE dd, yyyy');
//     String formattedDate = dateFormat.format(controller.currentDate.value);

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'Welcome back,',
//                           style: TextStyle(
//                             fontSize: fontSize,
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           'Michael',
//                           style: TextStyle(
//                             fontSize: fontSize,
//                             color: primaryColor,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 50),
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               formattedDate,
//                               style: TextStyle(fontSize: 0.7 * fontSize, color: primaryColor),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         GetBuilder<HomeController>(
//                           builder: (_) => PageView.builder(
//                             itemCount: controller.monthsInYear.value.length,
//                             controller: PageController(initialPage: controller.currentIndex.value),
//                             onPageChanged: (int index) => controller._onDaySelected(index),
//                             itemBuilder: (context, index) => Container(
//                               // Replace with your custom widget or layout for each month page
//                               child: Center(
//                                 child: Text(
//                                   getMonthName(controller.monthsInYear.value[index]),
//                                   style: TextStyle(fontSize: fontSize),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50), // Adjust spacing as needed
//                 // Add your InfoBar and SwipeButton widgets here
//                 InfoBar(text1: '', text2: '',), // Assuming InfoBar is a stateless widget
//                 const SizedBox(height: 20),
//                 SwipeButton(), // Assuming SwipeButton is a stateful widget with onPressed callback
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
