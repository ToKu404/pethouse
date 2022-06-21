import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import '../models/plan_model.dart';

abstract class PlanDataSource {
  Future<void> addPlan(PlanEntity plan);
  Stream<List<PlanEntity>> getPetPlan(String petId, DateTime date);
  Stream<List<PlanEntity>> getHistoryPlan(String petId);
  Future<void> changePlanStatus(String planId);
}

class PlanDataSourceImpl implements PlanDataSource {
  final FirebaseFirestore firebaseFireStore;

  PlanDataSourceImpl({required this.firebaseFireStore});

  @override
  Future<void> addPlan(PlanEntity plan) async {
    final collectionRef = firebaseFireStore.collection('plans');
    final planId = collectionRef.doc().id;

    //mengubah menjadi JSON
    collectionRef.doc(planId).get().then((value) {
      final newPlan = PlanModel(
              id: planId,
              petId: plan.petId,
              activity: plan.activity,
              date: plan.date,
              time: plan.time,
              activityTitle: plan.activityTitle,
              reminder: plan.reminder,
              location: plan.location,
              status: plan.status,
              description: plan.description)
          .toJson();
      if (!value.exists) {
        collectionRef.doc(planId).set(newPlan);
      }
      return;
    });
  }

  @override
  Stream<List<PlanEntity>> getPetPlan(String petId, DateTime date) {
    final petCollection = firebaseFireStore
        .collection('plans')
        .where('pet_id', isEqualTo: petId)
        .where('date', isEqualTo: DateFormat.yMMMEd().format(date));
    return petCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => PlanModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> changePlanStatus(String planId) async {
    final collectionRef = firebaseFireStore.collection('plans');
    Map<String, dynamic>? doc =
        await collectionRef.doc(planId).get().then((value) => value.data());
    String status = doc!['status'] == 'complete' ? 'waiting' : 'complete';
    final statusMap = {"status": status};
    await collectionRef.doc(planId).update(statusMap);
  }

  @override
  Stream<List<PlanEntity>> getHistoryPlan(String petId) {
    final petCollection = firebaseFireStore
        .collection('plans')
        .where('pet_id', isEqualTo: petId)
        .where('time', isLessThan: DateTime.now());
    return petCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => PlanModel.fromSnapshot(docSnap))
          .toList();
    });
  }
}
