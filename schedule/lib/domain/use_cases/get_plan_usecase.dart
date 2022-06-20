import '../entities/plan_entity.dart';
import '../repositories/plan_repository.dart';

class GetPlanUsecase {
  final PlanRepository planRepository;

  GetPlanUsecase({required this.planRepository});

  Stream<List<PlanEntity>> execute(String petId, DateTime date) {
    return planRepository.getPetPlan(petId, date);
  }
}
