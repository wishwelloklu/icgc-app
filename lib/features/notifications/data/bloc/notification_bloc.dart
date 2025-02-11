import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/notifications/data/bloc/notification_events.dart';
import 'package:icgc/features/notifications/data/bloc/notification_states.dart';
import 'package:icgc/features/notifications/data/models/notification.dart';

class NotificationBloc extends Bloc<NotificationEvents, NotificationStates> {
  NotificationBloc() : super(InitialNotificationState()) {
    on<LoadNotifications>(
      (event, emit) {
        emit(NotificationsLoaded(NotificationModel.notificationMock));
      },
    );
  }
}
