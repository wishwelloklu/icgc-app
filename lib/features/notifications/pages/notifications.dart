import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/app_states/app_error_state.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/notifications/widgets/notification_tile.dart';

import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/presentation/text/title_text.dart';
import '../data/bloc/notification_bloc.dart';
import '../data/bloc/notification_states.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    return Scaffold(
      appBar: AppBar(
        title: isTablet
            ? isPortrait
                ? TitleText(
                    text: AppString.notification,
                    fontSize: isTablet
                        ? AppFontSize.titleLarge
                        : AppFontSize.labelMedium,
                  )
                : null
            : const TitleText(
                text: AppString.declaration,
                fontSize: AppFontSize.labelMedium,
              ),
        toolbarHeight: kToolbarHeight *
            (isTablet
                ? isPortrait
                    ? 2
                    : 1
                : 1),
      ),
      body: BlocBuilder<NotificationBloc, NotificationStates>(
          builder: (context, state) {
        switch (state) {
          case NotificationsLoaded():
            final notifications = state.notifications;
            if (notifications.isNotEmpty) {
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationTile(notification);
                  });
            }
            return const AppEmptyStateWidget(
              title: AppString.noNotification,
              text: AppString.notificationText,
            );
          case ErrorNotificationState():
            return AppErrorState(error: state.error);
          default:
            return const AppLoadingState();
        }
      }),
    );
  }
}
