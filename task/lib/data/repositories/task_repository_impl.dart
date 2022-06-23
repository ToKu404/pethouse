import 'package:task/data/data_sources/task_firebase_data_source.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/repositories/task_repository.dart';

class TaskFirebaseRepositoryImpl implements TaskFirebaseRepository {
  final TaskFirebaseDataSource taskFirebaseDataSource;

  TaskFirebaseRepositoryImpl({required this.taskFirebaseDataSource});

  @override
  Future<void> changeTaskStatus(String taskId) {
    return taskFirebaseDataSource.changeTaskStatus(taskId);
  }

  @override
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate) {
    return taskFirebaseDataSource.getMonthlyTask(petId, startDate, endDate);
  }

  @override
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date) {
    return taskFirebaseDataSource.getTodayTask(petId, date);
  }

  @override
  Future<List<TaskEntity>> getOneReadTask(DateTime date, String petId) {
    return taskFirebaseDataSource.getOneReadTask(date, petId);
  }

  @override
  Future<void> transferTask(List<HabbitEntity> habbits, List<String> taskId) {
    return taskFirebaseDataSource.transferTask(habbits, taskId);
  }
}
