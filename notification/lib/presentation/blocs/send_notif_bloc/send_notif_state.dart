part of 'send_notif_bloc.dart';


abstract class SendNotifState extends Equatable{
  @override
  List<Object> get props => [];
}

class SendNotifInitial extends SendNotifState {}

class SendAdoptNotifSuccess extends SendNotifState {}