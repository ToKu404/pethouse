import 'package:notification/data/data_sources/notification_data_source.dart';
import 'package:notification/domain/entities/nofitication_entity.dart';
import 'package:notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource notificationDataSource;

  NotificationRepositoryImpl({required this.notificationDataSource});
  @override
  Stream<List<NotificationEntity>> getAllNotification(String uid) {
    return notificationDataSource.getAllNotification(uid);
  }

  @override
  Future<void> sendAdoptNotif(
      String idReceiver, NotificationEntity notificationEntity) {
    return notificationDataSource.sendAdoptNotif(
        idReceiver, notificationEntity);
  }
}
