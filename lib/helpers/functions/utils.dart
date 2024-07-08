import 'package:intl/intl.dart';

DateTime stringToDate(String date) {
  return DateTime.parse(date);
}

String readableDate(String date) {
  return DateFormat("hh:mm a").format(stringToDate(date));
}
