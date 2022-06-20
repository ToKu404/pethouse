import 'package:schedule/data/data_sources/plan_firebase_data_source.dart';
import 'package:schedule/domain/entities/plan_entity.dart';
import 'package:schedule/domain/repositories/plan_repository.dart';

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
}
