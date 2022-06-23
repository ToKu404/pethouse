import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  Future<FlutterLocalNotificationsPlugin?>
      get flutterLocalNotificationPluggin async {
    _flutterLocalNotificationsPlugin ??= await _initNotifications();
    return _flutterLocalNotificationsPlugin;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<FlutterLocalNotificationsPlugin> _initNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    return flutterLocalNotificationsPlugin;
  }

  Future showNotifications(
      int id, String title, String body, DateTime time) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "dicoding news channel";
    final notifPluggin = await flutterLocalNotificationPluggin;

    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    final location = tz.getLocation(currentTimeZone);
    final scheduleDate = tz.TZDateTime.from(time, location);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await notifPluggin!.zonedSchedule(
        id, title, body, scheduleDate, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
