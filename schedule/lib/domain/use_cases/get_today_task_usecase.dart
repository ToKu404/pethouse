import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/repositories/task_repository.dart';

class GetTodayTaskUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  GetTodayTaskUsecase(this.taskFirebaseRepository);

  Stream<List<TaskEntity>> execute(String petId, DateTime date) {
    return taskFirebaseRepository.getTodayTask(petId, date);
  }
}
