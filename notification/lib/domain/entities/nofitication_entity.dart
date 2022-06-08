import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? id;
  final String? title;
  final String? value;
  final String? type;
  final bool? readStatus;
  final Timestamp? sendTime;

  NotificationEntity(
      {this.id,
      required this.title,
      required this.value,
      required this.type,
      required this.readStatus,
      required this.sendTime});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, value, type, readStatus, sendTime];
}
