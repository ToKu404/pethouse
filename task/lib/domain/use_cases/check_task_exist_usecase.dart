import 'package:task/domain/repositories/task_repository.dart';

class CheckTaskExistUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  CheckTaskExistUsecase(this.taskFirebaseRepository);

  Future<bool> execute(String petId, DateTime date) {
    return taskFirebaseRepository.checkTaskExist(petId, date);
  }
}
