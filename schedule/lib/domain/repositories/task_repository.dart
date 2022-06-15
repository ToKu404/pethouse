import 'package:schedule/domain/entities/task_entity.dart';

abstract class TaskFirebaseRepository {
  Future<void> addTask(TaskEntity taskEntity);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Stream<List<TaskEntity>> getMonthlyTask(String petId, DateTime startDate, DateTime endDate);
  Future<void> changeTaskStatus(String taskId);
}
