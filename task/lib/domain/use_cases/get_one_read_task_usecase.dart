import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/repositories/task_repository.dart';

class GetOneReadTaskUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  GetOneReadTaskUsecase(this.taskFirebaseRepository);

  Future<List<TaskEntity>> execute(DateTime date, String petId) {
    return taskFirebaseRepository.getOneReadTask(date, petId);
  }
}
