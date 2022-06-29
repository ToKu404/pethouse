import 'package:notification/domain/repositories/notification_repository.dart';

class ClearNotificationUsecase {
  final NotificationRepository notificationRepository;

  ClearNotificationUsecase(this.notificationRepository);

  Future<void> execute(String uid) {
    return notificationRepository.clearNotification(uid);
  }
}
