import 'package:equatable/equatable.dart';
import 'package:icgc/features/notifications/data/models/notification.dart';

abstract class NotificationStates extends Equatable {}

class InitialNotificationState extends NotificationStates {
  @override
  List<Object?> get props => [];
}

class NotificationsLoaded extends NotificationStates {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);
  @override
  List<Object?> get props => [notifications];
}

class ErrorNotificationState extends NotificationStates {
  final String error;
  ErrorNotificationState(this.error);
  @override
  List<Object?> get props => [error];
}
