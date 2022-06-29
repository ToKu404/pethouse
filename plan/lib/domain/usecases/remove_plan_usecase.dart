import 'package:plan/domain/repositories/plan_repository.dart';

class RemovePlanUsecase {
  final PlanRepository planRepository;
  RemovePlanUsecase(this.planRepository);

  Future<void> execute(String planId) {
    return planRepository.removePlan(planId);
  }
}
