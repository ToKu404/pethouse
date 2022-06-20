import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskFirebaseRepository firebaseRepository;
  AddTaskUseCase({required this.firebaseRepository});

  Future<void> execute(TaskEntity taskEntity) async {
    return firebaseRepository.addTask(taskEntity);
  }
}
