import 'package:notification/domain/entities/nofitication_entity.dart';
import 'package:notification/domain/repositories/notification_repository.dart';

class SendAdoptNotifUsecase {
  final NotificationRepository notificationRepository;

  SendAdoptNotifUsecase(this.notificationRepository);

  Future<void> execute(
      String idReceiver, NotificationEntity notificationEntity) {
    return notificationRepository.sendAdoptNotif(
        idReceiver, notificationEntity);
  }
}
