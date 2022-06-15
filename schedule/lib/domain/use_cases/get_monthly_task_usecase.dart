import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/repositories/task_repository.dart';

class GetMonthlyTaskUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  GetMonthlyTaskUsecase(this.taskFirebaseRepository);

  Stream<List<TaskEntity>> execute(
      String petId, DateTime startDate, DateTime endDate) {
    return taskFirebaseRepository.getMonthlyTask(petId, startDate, endDate);
  }
}
