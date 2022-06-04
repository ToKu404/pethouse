import 'package:schedule/activity/domain/entities/task_entity.dart';
import 'package:schedule/activity/domain/repositories/taskadd_firebase_repository.dart';

class AddTaskUseCase{
  final TaskFirebaseRepository firebaseRepository;
  AddTaskUseCase({required this.firebaseRepository});

  Future<void> execute(TaskEntity taskEntity) async{
    return firebaseRepository.addTask(taskEntity);
  }
}