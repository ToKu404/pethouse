import 'package:plan/domain/repositories/plan_repository.dart';

class GetPlanNotifIdUsecase {
  final PlanRepository planRepository;

  GetPlanNotifIdUsecase(this.planRepository);

  Future<List<int>> execute(String petId) {
    return planRepository.getPlanNotifId(petId);
  }
}
