import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get timePeriodFormat {
    final datetime = this;
    final formattedTime = DateFormat('hh:mm a').format(datetime);
    return formattedTime;
  }

  String get dateFormat {
    final datetime = this;
    final formattedTime = DateFormat('d MMMM yyyy').format(datetime);
    return formattedTime;
  }

  String get relativeDayLabel  {
    final now = DateTime.now();
    final messageDate = DateTime(year, month, day);
    final nowDate = DateTime(now.year, now.month, now.day);

    final difference = nowDate.difference(messageDate).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if(difference < 7) {
      return weekdayName;
    }else {
      return dateFormat;
    }
  }

  String get weekdayName {
    const weekdays = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday];
  }

  String get lastTimeFormat {
    final now = DateTime.now();
    final messageDate = DateTime(year, month, day);
    final nowDate = DateTime(now.year, now.month, now.day);

    final difference = nowDate.difference(messageDate).inDays;

    debugPrint('Difference is: ${nowDate.difference(messageDate).inDays}');

    debugPrint('MessageDate is: $messageDate');
    debugPrint('NowDate is: $nowDate');

    if (difference == 0) {
      return timePeriodFormat;
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return dateFormat;
    }
  }
}
