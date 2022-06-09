part of 'send_notif_bloc.dart';

abstract class SendNotifEvent extends Equatable {
  const SendNotifEvent();
  @override
  List<Object> get props => [];
}

class SendAdoptNotification extends SendNotifEvent {
  final String ownerId;
  final NotificationEntity notificationEntity;

  const SendAdoptNotification(
      {required this.ownerId, required this.notificationEntity});

  @override
  List<Object> get props => [ownerId, notificationEntity];
}

