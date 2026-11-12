import 'package:intl/intl.dart';

/// تنسيق التواريخ باللغة العربية مع معالجة استباقية للأخطاء والتهيئة
class AppDateFormatter {
  static DateFormat get _fullDate {
    try {
      return DateFormat('yyyy/MM/dd', 'ar');
    } catch (_) {
      return DateFormat('yyyy/MM/dd');
    }
  }

  static DateFormat get _dateTime {
    try {
      return DateFormat('yyyy/MM/dd - hh:mm a', 'ar');
    } catch (_) {
      return DateFormat('yyyy/MM/dd - hh:mm a');
    }
  }

  static DateFormat get _timeOnly {
    try {
      return DateFormat('hh:mm a', 'ar');
    } catch (_) {
      return DateFormat('hh:mm a');
    }
  }

  static DateFormat get _monthYear {
    try {
      return DateFormat('MMMM yyyy', 'ar');
    } catch (_) {
      return DateFormat('MMMM yyyy');
    }
  }

  static DateFormat get _dayMonth {
    try {
      return DateFormat('d MMMM', 'ar');
    } catch (_) {
      return DateFormat('d MMMM');
    }
  }

  static String formatDate(DateTime? date) {
    if (date == null) return '-';
    try {
      return _fullDate.format(date);
    } catch (_) {
      return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    }
  }

  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    try {
      return _dateTime.format(dateTime);
    } catch (_) {
      return '${formatDate(dateTime)} - ${formatTime(dateTime)}';
    }
  }

  static String formatTime(DateTime? time) {
    if (time == null) return '-';
    try {
      return _timeOnly.format(time);
    } catch (_) {
      final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
      final amPm = time.hour >= 12 ? 'م' : 'ص';
      return '$hour:${time.minute.toString().padLeft(2, '0')} $amPm';
    }
  }

  static String formatMonthYear(DateTime date) {
    try {
      return _monthYear.format(date);
    } catch (_) {
      return '${date.month}/${date.year}';
    }
  }

  static String formatDayMonth(DateTime date) {
    try {
      return _dayMonth.format(date);
    } catch (_) {
      return '${date.day}/${date.month}';
    }
  }

  /// تحويل Unix Epoch بالمللي ثانية إلى نص تاريخ
  static String formatTimestamp(int? millis) {
    if (millis == null || millis <= 0) return '-';
    return formatDate(DateTime.fromMillisecondsSinceEpoch(millis));
  }

  /// تحويل Unix Epoch بالمللي ثانية إلى تاريخ ووقت
  static String formatTimestampWithTime(int? millis) {
    if (millis == null || millis <= 0) return '-';
    return formatDateTime(DateTime.fromMillisecondsSinceEpoch(millis));
  }
}
