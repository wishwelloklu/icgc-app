import 'package:flutter/material.dart';
import 'package:icgc/app/utils/date_time.dart';
import 'package:icgc/core/presentation/cards/app_list_tile.dart';
import 'package:icgc/core/presentation/cards/round_text_card.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/features/notifications/data/models/notification.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(this.notification, {super.key});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final title = notification.title;
    final message = notification.message;
    final date = notification.date;
    return AppListTile(
        leading: RoundTextCard(title),
        title: title,
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [DescriptionText(text: date.formattedDateTime)],
        ),
        subTitle: message);
  }
}
