import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:core/core.dart';

abstract class ScheduleDataSource {
  Future<bool> scheduleTask(bool value, String time);
}

class ScheduleDataSourceImpl implements ScheduleDataSource {
  @override
  Future<bool> scheduleTask(bool value, String time) async {
    if (value) {
      print('Schedule Activated');
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 2, BackgroundService.callback,
          startAt: DateTimeHelper.format(time), exact: true, wakeup: true);
    } else {
      return AndroidAlarmManager.cancel(2);
    }
  }
}
