import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/repositories/plan_repository.dart';

class EditPlanUsecase {
  final PlanRepository planRepository;

  EditPlanUsecase(this.planRepository);

  Future<void> execute(PlanEntity planEntity) {
    return planRepository.editPlan(planEntity);
  }
}
