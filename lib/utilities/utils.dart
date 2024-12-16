
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils{

  static String getDayText(String date) {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day));
    DateTime givenDate = DateFormat('yyyy-MM-dd').parse(date); // Parse the date string
    String dayText = '';

    String formattedGivenDate = DateFormat('yyyy-MM-dd').format(givenDate);

    if (currentDate == formattedGivenDate) {
      dayText = 'Today';
    } else if (formattedGivenDate == DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)))) {
      dayText = "Yesterday";
    } else if(formattedGivenDate == DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1)))){
      dayText = 'Tomorrow';
    }else {
      dayText = DateFormat('dd-MM-yyyy').format(givenDate);
    }

    return dayText;
  }

  static String formatTime(String time) {
    try {
      final parts = time.split(':');

      if (parts.length >= 2) {
        // Take the first two parts (hours and minutes)
        final formattedTime = '${parts[0]}:${parts[1]}';
        return formattedTime;
      } else {
        throw const FormatException('Invalid time format');
      }
    } catch (e) {
      debugPrint('Error formatting time: $e');
      return time; // Return the original time in case of error
    }
  }



}




