
import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/repositories/task_repository.dart';

class GetMonthlyTaskUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  GetMonthlyTaskUsecase(this.taskFirebaseRepository);

  Stream<List<TaskEntity>> execute(
      String petId, DateTime startDate, DateTime endDate) {
    return taskFirebaseRepository.getMonthlyTask(petId, startDate, endDate);
  }
}
