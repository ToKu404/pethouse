import 'package:task/domain/entities/date_task_entity.dart';
import 'package:task/domain/entities/task_entity.dart';
import '../entities/habbit_entity.dart';

abstract class TaskFirebaseRepository {
  Future<List<TaskEntity>> getOneReadTask(DateTime date, String petId);
  Future<void> transferTask(
      List<HabbitEntity> habbits, List<String> taskId);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate);
  Future<void> changeTaskStatus(String taskId);
}
