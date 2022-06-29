import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/domain/entities/habbit_entity.dart';

import '../models/habbit_model.dart';

abstract class HabbitDataSource {
  Future<void> insertHabbit(HabbitEntity habbitEntity);
  Stream<List<HabbitEntity>> getTodayHabbit(String dayName, String petId);
  Future<void> removeHabbit(String habbitId);
  Stream<List<HabbitEntity>> getAllHabbits(String petId);
  Future<List<HabbitEntity>> getOneReadHabbits(String petId);
}

class HabbitDataSourceImpl implements HabbitDataSource {
  final FirebaseFirestore firebaseFirestore;

  HabbitDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<void> insertHabbit(HabbitEntity habbitEntity) async {
    final collectionRef = firebaseFirestore.collection('habbits');
    final habbitId = collectionRef.doc().id;

    collectionRef.doc(habbitId).get().then((value) {
      final newHabbit = HabbitModel(
          id: habbitId,
          petId: habbitEntity.petId,
          activityType: habbitEntity.activityType,
          dayRepeat: habbitEntity.dayRepeat,
          title: habbitEntity.title,
          repeat: habbitEntity.repeat,
          time: habbitEntity.time);
      if (!value.exists) {
        collectionRef.doc(habbitId).set(newHabbit.toJson());
      }
      return;
    });
  }

  @override
  Future<void> removeHabbit(String habbitId) async {
    await firebaseFirestore.collection('habbits').doc(habbitId).delete();
  }

  @override
  Stream<List<HabbitEntity>> getTodayHabbit(String dayName, String petId) {
    final collectionRef = firebaseFirestore
        .collection('habbits')
        .where('pet_id', isEqualTo: petId)
        .where('day_repeat', arrayContains: dayName);
    return collectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => HabbitModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<HabbitEntity>> getAllHabbits(String petId) {
    final collectionRef = firebaseFirestore
        .collection('habbits')
        .where('pet_id', isEqualTo: petId);
    return collectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => HabbitModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<List<HabbitEntity>> getOneReadHabbits(String petId) {
    print("CALLER HABBIT");
    final collectionRef = firebaseFirestore
        .collection('habbits')
        .where('pet_id', isEqualTo: petId);
    return collectionRef.get().then((value) {
      return value.docs.map((e) => HabbitModel.fromSnapshot(e)).toList();
    });
  }
}
