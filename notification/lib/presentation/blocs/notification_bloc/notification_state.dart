part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;

  NotificationError({required this.message});

  @override
  List<Object> get props => [message];
}

class NotificationSuccess extends NotificationState {
  final List<NotificationEntity> listNotification;

  NotificationSuccess({required this.listNotification});

  @override
  List<Object> get props => [listNotification];
}


