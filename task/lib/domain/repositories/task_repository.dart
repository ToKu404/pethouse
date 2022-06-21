import 'package:task/domain/entities/task_entity.dart';
import '../entities/habbit_entity.dart';

abstract class TaskFirebaseRepository {
  Future<bool> checkTaskExist(String petId, DateTime date);
  Future<void> transferTask(List<HabbitEntity> habbits, DateTime date, String petId);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate);
  Future<void> changeTaskStatus(String taskId);
}
