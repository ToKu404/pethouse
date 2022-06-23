import 'package:core/services/notification_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_notification_state.dart';

class SettingNotificationCubit extends Cubit<SettingNotificationState> {
  final NotificationHelper notificationHelper;
  SettingNotificationCubit({required this.notificationHelper})
      : super(SettingNotificationInitial());

  Future<void> initNotification(
      {required DateTime date, required int notifId, required String eventName, String eventDesc = ''}) async {
    await notificationHelper.showNotifications(
        notifId, eventName, eventDesc, date);
    emit(SettingNotificationSuccess());
  }
}
