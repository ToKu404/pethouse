part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetListNotification extends NotificationEvent {
  final List<NotificationEntity> listNotification;

  const GetListNotification({required this.listNotification});

  @override
  List<Object> get props => [listNotification];
}

class FetchListNotification extends NotificationEvent {

}
