import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification/data/models/notification_model.dart';

import '../../domain/entities/nofitication_entity.dart';

abstract class NotificationDataSource {
  Stream<List<NotificationEntity>> getAllNotification(String uid);
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
}
