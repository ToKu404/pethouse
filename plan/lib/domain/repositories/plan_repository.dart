import '../entities/plan_entity.dart';

abstract class PlanRepository {
  Future<void> addPlan(PlanEntity planEntity);
  Future<void> editPlan(PlanEntity planEntity);
  Future<void> removePlan(String planId);
  Stream<List<PlanEntity>> getPetPlan(String petId, DateTime date);
  Future<List<int>> getPlanNotifId(String petId, DateTime date);
  Stream<List<PlanEntity>> getHistoryPlan(String petId);
  Future<void> changePlanStatus(String planId);
}
