// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;
  const NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    required this.isRead,
  });

  NotificationModel copyWith({
    String? title,
    String? message,
    DateTime? date,
    bool? isRead,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'date': date.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isRead: map['isRead'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, message, date, isRead];

  static List<NotificationModel> notificationMock = [
    NotificationModel(
      title: 'New book uploaded',
      message:
          'A new book from Pastor Mensah Otabil titled, God is With Us is added to the your archives',
      date: DateTime(2024),
      isRead: false,
    ),
    NotificationModel(
      title: '2025 Pastors forum',
      message:
          'The Pastors forum 2025 is here, The event will start on the 20th of january',
      date: DateTime(2025, 1, 2),
      isRead: true,
    ),
    NotificationModel(
      title: '2025 Pastors forum',
      message:
          'The Pastors forum 2025 is here, The event will start on the 20th of january',
      date: DateTime(2025, 1, 2),
      isRead: true,
    ),
    NotificationModel(
      title: '2025 Pastors forum',
      message:
          'The Pastors forum 2025 is here, The event will start on the 20th of january',
      date: DateTime(2025, 1, 2),
      isRead: true,
    )
  ];
}
