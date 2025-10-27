import 'package:flutter/material.dart';

class Formatter {
  static String timeFormatter({
    TimeOfDay? time,
    DateTime? dateTime,
    bool showDate = false,
  }) {
    String rtn = "";

    if (time == null && dateTime != null) {
      time = TimeOfDay.fromDateTime(dateTime);
    }

    if (time == null) {
      return "null";
    }

    if (showDate && dateTime != null) {
      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day - 1);

      final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (dateOnly == yesterday) {
        rtn += "Yesterday at ";
      } else {
        rtn += "${dateTime.day} ${monthName(dateTime.month)} at ";
      }
    }

    rtn += time.hourOfPeriod.toString();
    rtn += ":";
    rtn += time.minute.toString().padLeft(2, "0");
    rtn += " ";
    rtn += time.period == DayPeriod.am ? "AM" : "PM";

    return rtn;
  }

  static String monthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }

    return "Invalid Month";
  }

  static String countdown(Duration duration) {
    String rtn = "";

    rtn += duration.inMinutes.toString();
    rtn += ":";
    rtn += (duration.inSeconds - (duration.inMinutes * 60)).toString().padLeft(
      2,
      "0",
    );

    return rtn;
  }

  static String dateFormatter(DateTime date) {
    String rtn = "";

    rtn += date.year.toString();
    rtn += "-";

    rtn += date.month.toString();
    rtn += "-";

    rtn += date.day.toString();

    return rtn;
  }

  static String durationFormatter(
    Duration duration, {
    bool showSeconds = false,
  }) {
    String rtn = "";

    if (duration.inDays != 0) {
      rtn += duration.inDays.toString();
      rtn += "d ";
      duration -= Duration(days: duration.inDays);
    }

    if (duration.inHours != 0) {
      rtn += duration.inHours.toString();
      rtn += "h ";
      duration -= Duration(hours: duration.inHours);
    }

    if (duration.inMinutes >= 0) {
      rtn += duration.inMinutes.toString();
      rtn += "m";
      duration -= Duration(hours: duration.inMinutes);
    }

    if (showSeconds) {
      rtn += " ";
      rtn += duration.inSeconds.toString();
      rtn += "s";
    }

    return rtn;
  }

  static String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
