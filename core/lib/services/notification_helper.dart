import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      TaskNotifEntity notif) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "pethouse_task";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        groupKey: 'notification_group',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Headline News</b>";
    var titleNews = 'Task Title';

    await flutterLocalNotificationsPlugin.show(
      1,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
    );
    // payload: json.encode(articles.toJson()));
  } 

  // void configureSelectNotificationSubject(String route) {
  //   selectNotificationSubject.stream.listen(
  //     (String payload) async {
  //       var data = ArticlesResult.fromJson(json.decode(payload));
  //       var article = data.articles[0];
  //       Navigation.intentWithData(route, article);
  //     },
  //   );
  // }
}

class TaskNotifEntity {}
