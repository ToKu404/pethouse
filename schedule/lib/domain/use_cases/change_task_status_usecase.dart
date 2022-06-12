import 'package:schedule/domain/repositories/task_repository.dart';

class ChangeTaskStatusUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  ChangeTaskStatusUsecase(this.taskFirebaseRepository);

  Future<void> execute(String taskId) {
    return taskFirebaseRepository.changeTaskStatus(taskId);
  }
}
