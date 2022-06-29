import 'package:task/domain/entities/task_entity.dart';
import '../entities/habbit_entity.dart';

abstract class TaskFirebaseRepository {
  Future<List<TaskEntity>> getOneReadTask(DateTime date, String petId);
  Future<void> transferTask(
      List<HabbitEntity> habbits, List<TaskEntity> tasks);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate);
  Future<void> changeTaskStatus(String taskId);
}
