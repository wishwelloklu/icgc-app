import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd MMM yy');
final weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

extension DateTimeExtension on DateTime {
  String deliveredTime() {
    final token = toIso8601String().split("T").last.split(".").first.split(":");
    return "${token[0]}:${token[1]}";
  }

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return formatTime(); // Today
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return weekdays[weekday - 1]; // Within this week
    } else {
      return formatter.format(this); // Other dates
    }
  }

  String formatTime() {
    final token = toIso8601String().split("T").last.split(".").first.split(":");
    return "${token[0]}:${token[1]}";
  }
}
