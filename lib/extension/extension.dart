import 'dart:convert';

import 'package:intl/intl.dart';

extension ExtString on String {
  String removeZeroFloatingPoint() {
    return replaceFirst(RegExp(r'\.?0*$'), '');
  }
}

extension ExtDate on DateTime {
  String yyyyMMddHHmmss() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  String timestamp({
    String formatStr = 'dd/MM/yyyy HH:mm:ss',
    String locale = 'EN',
  }) {
    return DateFormat(formatStr, locale).format(this);
  }

  DateTime previousMonth() {
    DateTime firstDayOfTheMonth = startOfTheMonth();
    int totalDaysInMonth =
        firstDayOfTheMonth.subtract(const Duration(days: 1)).day;

    if (day < totalDaysInMonth) {
      return DateTime(year, month - 1, day, hour, minute, second);
    } else {
      return DateTime(year, month - 1, totalDaysInMonth, hour, minute, second);
    }
  }

  DateTime nextDay() {
    return DateTime(year, month, day + 1, hour, minute, second);
  }

  DateTime nextMonth() {
    return DateTime(year, month + 1, day, hour, minute, second);
  }

  DateTime previousYear() {
    return DateTime(year - 1, month, day, hour, minute, second);
  }

  DateTime nextYear() {
    return DateTime(year + 1, month, day, hour, minute, second);
  }

  DateTime firstDayOfTheMonth() {
    return DateTime(year, month, 1);
  }

  DateTime lastDayOfTheMonth() {
    return DateTime(year, month + 1, 0);
  }

  DateTime startOfTheDay() {
    return DateTime(year, month, day, 0, 0, 0);
  }

  DateTime endOfTheDay() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  DateTime startOfTheMonth() {
    return DateTime(year, month, 1, 0, 0, 0);
  }

  DateTime endOfTheMonth() {
    return DateTime(year, month + 1, 1, 0, 0, -1);
  }

  DateTime startOfTheYear() {
    return DateTime(year, 1, 1, 0, 0, 0);
  }

  DateTime endOfTheYear() {
    return DateTime(year + 1, 1, 1, 0, 0, -1);
  }

  bool isSameDay(DateTime? a) {
    if (a == null) {
      return false;
    }

    return a.year == year && a.month == month && a.day == day;
  }

  bool isSameMonth(DateTime? a) {
    if (a == null) {
      return false;
    }

    return a.year == year && a.month == month;
  }

  bool isSameYear(DateTime? a) {
    if (a == null) {
      return false;
    }

    return a.year == year;
  }

  bool isBetween(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    if (a.isBefore(b)) {
      return isSameDay(a) || isAfter(a) && isBefore(b) || isSameDay(b);
    }

    return isSameDay(b) || isAfter(b) && isBefore(a) || isSameDay(a);
  }

  DateTime nearestTime() {
    int nearestMinute = 45;

    if (minute < 15) {
      nearestMinute = 0;
    } else if (minute < 30) {
      nearestMinute = 15;
    } else if (minute < 45) {
      nearestMinute = 30;
    }

    return DateTime(year, month, day, hour, nearestMinute, 0);
  }
}

extension ExtInt on int {
  String monthName(bool isAbbr) {
    switch (this) {
      case 1:
        return isAbbr ? 'jan.' : 'january';

      case 2:
        return isAbbr ? 'feb.' : 'february';

      case 3:
        return isAbbr ? 'mar.' : 'march';

      case 4:
        return isAbbr ? 'apr.' : 'april';

      case 5:
        return isAbbr ? 'may.' : 'may';

      case 6:
        return isAbbr ? 'jun.' : 'june';

      case 7:
        return isAbbr ? 'jul.' : 'july';

      case 8:
        return isAbbr ? 'aug.' : 'august';

      case 9:
        return isAbbr ? 'sep.' : 'september';

      case 10:
        return isAbbr ? 'oct.' : 'october';

      case 11:
        return isAbbr ? 'nov.' : 'november';

      case 12:
        return isAbbr ? 'dec.' : 'december';

      default:
        return '';
    }
  }

  String dayName(bool isAbbr) {
    switch (this) {
      case 0:
        return isAbbr ? 'sun.' : 'sunday';

      case 1:
        return isAbbr ? 'mon.' : 'monday';

      case 2:
        return isAbbr ? 'tue.' : 'tuesday';

      case 3:
        return isAbbr ? 'wed.' : 'wednesday';

      case 4:
        return isAbbr ? 'thu.' : 'thursday';

      case 5:
        return isAbbr ? 'fri.' : 'friday';

      case 6:
        return isAbbr ? 'sat.' : 'saturday';

      default:
        return '';
    }
  }

  String toDayString({bool isAbbr = false}) {
    if (isAbbr) {
      return '$this ${'d'}';
    }

    return this == 1 ? '$this ${'day'}' : '$this ${'days'}';
  }
}

extension ExtDouble on double {
  String toHourString({bool isAbbr = false, bool convertToDay = false}) {
    int day = 0;
    double remaining = this;

    // คิด 8 ชม. เป็น 1 วัน
    if (convertToDay) {
      day = (this / 8).floor();
      remaining = this - (day * 8);
    }

    String hourString = remaining.toString().removeZeroFloatingPoint();

    if (isAbbr) {
      return day == 0
          ? '$hourString ${'h'}'
          : remaining == 0
          ? '$day ${'d'}'
          : '$day ${'d'} $hourString ${'h'}';
    }

    return day == 0
        ? '$hourString ${remaining == 1 ? 'hour' : 'hours'}'
        : remaining == 0
        ? '$day ${day == 1 ? 'day' : 'days'}'
        : '$day ${day == 1 ? 'day' : 'days'} $hourString ${remaining == 1 ? 'hour' : 'hours'}';
  }
}

String formattedJSON(Object source) {
  return const JsonEncoder.withIndent('    ').convert(source);
}