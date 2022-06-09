import 'package:notification/domain/entities/nofitication_entity.dart';

abstract class NotificationRepository {
  Stream<List<NotificationEntity>> getAllNotification(String uid);
  Future<void> sendAdoptNotif(
      String idReceiver, NotificationEntity notificationEntity);
}
