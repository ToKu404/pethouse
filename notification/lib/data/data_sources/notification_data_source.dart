import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification/data/models/notification_model.dart';

import '../../domain/entities/nofitication_entity.dart';

abstract class NotificationDataSource {
  Stream<List<NotificationEntity>> getAllNotification(String uid);
  Future<void> sendAdoptNotif(
      String idReceiver, NotificationEntity notificationEntity);
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final FirebaseFirestore firebaseFirestore;

  NotificationDataSourceImpl({required this.firebaseFirestore});

  @override
  Stream<List<NotificationEntity>> getAllNotification(String uid) {
    try {
      final collectionRef =
          firebaseFirestore.collection('notifications').doc(uid).snapshots();
      return collectionRef.map((result) {
        final listNotif = List.from(result.get('all_notif'))
            .map((data) => NotificationModel.fromMap(data))
            .toList();
        return listNotif;
      });
    } catch (_) {
      return Stream.error('empty data');
    }
  }

  @override
  Future<void> sendAdoptNotif(
      String idReceiver, NotificationEntity notificationEntity) async {
    final data = NotificationModel(
            readStatus: notificationEntity.readStatus,
            sendTime: notificationEntity.sendTime,
            type: notificationEntity.type,
            title: notificationEntity.title,
            value: notificationEntity.value)
        .toDocument();
    await firebaseFirestore.collection('notifications').doc(idReceiver).update({
      "all_notif": FieldValue.arrayUnion([data])
    });
  }
}
