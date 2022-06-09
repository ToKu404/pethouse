import 'package:notification/domain/repositories/notification_repository.dart';

import '../entities/nofitication_entity.dart';

class GetListNotificationUsecase {
  final NotificationRepository notificationRepository;

  GetListNotificationUsecase({required this.notificationRepository});

  Stream<List<NotificationEntity>> execute(String uid) {
    return notificationRepository.getAllNotification(uid);
  }
}
