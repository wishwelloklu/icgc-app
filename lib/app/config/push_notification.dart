import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PushNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'default_notification_channel_id',
    'All Notification',
    description: 'Incoming Notification',
    importance: Importance.max,
    playSound: true,
  );

  static Future<void> initLocalNotificaton() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(_channel);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestFullScreenIntentPermission();

    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Africa/Accra'));

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> setReminder({
    int id = 0,
    required String title,
    required String body,
    required DateTime date,
  }) async {
    final duration = date.difference(DateTime.now());
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      playSound: _channel.playSound,
      priority: Priority.high,
      importance: Importance.max,
      fullScreenIntent: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(duration),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    // await _flutterLocalNotificationsPlugin.show(
    //   id,
    //   title,
    //   body,
    //   notificationDetails,
    // );
    print('qddadasdsd');
  }
}
