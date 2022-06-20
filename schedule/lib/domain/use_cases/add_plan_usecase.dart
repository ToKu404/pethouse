import 'package:schedule/domain/entities/plan_entity.dart';
import 'package:schedule/domain/repositories/plan_repository.dart';

class AddPlanUsecase {
  final PlanRepository firebaseRepository;
  AddPlanUsecase({required this.firebaseRepository});

  Future<void> execute(PlanEntity planEntity) async {
    return firebaseRepository.addPlan(planEntity);
  }
}
