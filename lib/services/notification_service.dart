import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paalala/models/schedule.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';

import 'package:paalala/models/task/task.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const channelId = '123';

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  final AndroidNotificationDetails _androidNotificationDetails = const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    channelDescription: 'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  void showNotification(Task task) {
    final key = task.key ?? 9999;

    flutterLocalNotificationsPlugin.show(
      key,
      task.title,
      task.taskDeadline.toString(),
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> showNotificationAt(Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(task.key, task.title, task.description,
        task.taskDeadline, NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  //Future<void> repeatNotification(Task task, Duration) async {}

  Future<void> showNotificationPeriodic(Task task, RepeatInterval interval) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      task.key,
      task.title,
      task.description,
      interval,
      NotificationDetails(android: _androidNotificationDetails),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleNotification(Task task) async {
    late Duration duration;
    switch (task.notificationFrequency) {
      case Frequency.hourly:
        showNotificationPeriodic(task, RepeatInterval.hourly);
        break;
      case Frequency.daily:
        showNotificationPeriodic(task, RepeatInterval.daily);
        break;
      case Frequency.weekly:
        showNotificationPeriodic(task, RepeatInterval.weekly);
        break;
      default:
        break;
    }
    // await flutterLocalNotificationsPlugin.zonedSchedule(task.key, task.title, task.description,
    //     task.taskDeadline, NotificationDetails(android: _androidNotificationDetails),
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(Task task) async {
    await flutterLocalNotificationsPlugin.cancel(task.key);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void manangeNotifFrequency(Task task) {
    final frequency = task.notificationFrequency;

    switch (frequency) {
      case Frequency.hourly:

      case Frequency.daily:

      case Frequency.weekly:

      case Frequency.monthly:

      case Frequency.yearly:

      default:
    }
  }
}
