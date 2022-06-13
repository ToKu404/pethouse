import 'package:schedule/data/data_sources/task_firebase_data_source.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/repositories/task_repository.dart';

class TaskFirebaseRepositoryImpl implements TaskFirebaseRepository {
  final TaskFirebaseDataSource taskFirebaseDataSource;

  TaskFirebaseRepositoryImpl({required this.taskFirebaseDataSource});

  @override
  Future<void> addTask(TaskEntity taskEntity) async {
    taskFirebaseDataSource.addTask(taskEntity);
  }

  @override
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date) {
    return taskFirebaseDataSource.getTodayTask(petId, date);
  }
  @override
  Future<void> changeTaskStatus(String taskId) {
    return taskFirebaseDataSource.changeTaskStatus(taskId);
  }
}