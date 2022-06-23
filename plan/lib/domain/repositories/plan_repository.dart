import '../entities/plan_entity.dart';

abstract class PlanRepository {
  Future<void> addPlan(PlanEntity planEntity);
  Stream<List<PlanEntity>> getPetPlan(String petId, DateTime date);
  Future<List<int>> getPlanNotifId(String petId);
  Stream<List<PlanEntity>> getHistoryPlan(String petId);
  Future<void> changePlanStatus(String planId);
}
