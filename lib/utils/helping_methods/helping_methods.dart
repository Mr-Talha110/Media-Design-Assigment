import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String formatDate(DateTime date) {
  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String month = DateFormat('MMMM').format(date);
  int day = date.day;
  String suffix = getDaySuffix(day);
  String year = DateFormat('y').format(date);
  return '$month $day$suffix $year';
}
