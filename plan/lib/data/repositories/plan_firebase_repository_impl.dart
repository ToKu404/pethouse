import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/repositories/plan_repository.dart';

import '../data_sources/plan_firebase_data_source.dart';

class PlanRepositoryImpl implements PlanRepository {
  final PlanDataSource planDataSource;

  PlanRepositoryImpl({required this.planDataSource});

  @override
  Future<void> addPlan(PlanEntity planEntity) async {
    planDataSource.addPlan(planEntity);
  }

  @override
  Stream<List<PlanEntity>> getPetPlan(String petId, DateTime date) {
    return planDataSource.getPetPlan(petId, date);
  }

  @override
  Future<void> changePlanStatus(String planId) {
    return planDataSource.changePlanStatus(planId);
  }

  @override
  Stream<List<PlanEntity>> getHistoryPlan(String petId) {
    return planDataSource.getHistoryPlan(petId);
  }

  @override
  Future<List<int>> getPlanNotifId(String petId, DateTime date) {
    return planDataSource.getPlanNotifId(petId, date);
  }
}
