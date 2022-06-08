import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification/domain/entities/nofitication_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    final String? id,
    final String? title,
    final String? value,
    final String? type,
    final bool? readStatus,
    final Timestamp? sendTime,
  }) : super(
            readStatus: readStatus,
            id: id,
            sendTime: sendTime,
            title: title,
            type: type,
            value: value);

  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "title": title,
      "value": value,
      "type": type,
      "read_status": readStatus,
      "send_time": sendTime
    };
  }

  factory NotificationModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return NotificationModel(
      id: documentSnapshot.get('id'),
      title: documentSnapshot.get('title'),
      value: documentSnapshot.get('value'),
      type: documentSnapshot.get('type'),
      readStatus: documentSnapshot.get('read_status'),
      sendTime: documentSnapshot.get('send_time'),
    );
  }
  factory NotificationModel.fromMap(Map<dynamic, dynamic> data) {
    return NotificationModel(
      id: data['id'],
      title: data['title'],
      value: data['value'],
      type: data['type'],
      readStatus: data['read_status'],
      sendTime: data['send_time'],
    );
  }

  @override
  List<Object?> get props => [id, title, value, type, readStatus, sendTime];
}
