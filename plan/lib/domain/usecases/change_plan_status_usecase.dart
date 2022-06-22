import 'package:plan/domain/repositories/plan_repository.dart';

class ChangePlanStatusUsecase {
  final PlanRepository planRepository;

  ChangePlanStatusUsecase(this.planRepository);

  Future<void> execute(String planId) {
    return planRepository.changePlanStatus(planId);
  }
}
