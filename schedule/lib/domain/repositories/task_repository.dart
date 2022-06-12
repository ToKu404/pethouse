import 'package:schedule/domain/entities/task_entity.dart';

abstract class TaskFirebaseRepository {
  Future<void> addTask(TaskEntity taskEntity);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Future<void> changeTaskStatus(String taskId);
}
