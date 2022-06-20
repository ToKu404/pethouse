import 'package:schedule/domain/entities/plan_entity.dart';
import 'package:schedule/domain/repositories/plan_repository.dart';

class GetPlanHistoryUsecase {
  final PlanRepository planRepository;

  GetPlanHistoryUsecase(this.planRepository);

  Stream<List<PlanEntity>> execute(String petId) {
    return planRepository.getHistoryPlan(petId);
  }
}
