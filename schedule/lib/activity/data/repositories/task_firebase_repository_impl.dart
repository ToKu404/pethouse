
import 'package:schedule/activity/data/data_sources/task_firebase_data_source.dart';
import 'package:schedule/activity/domain/entities/task_entity.dart';
import 'package:schedule/activity/domain/repositories/taskadd_firebase_repository.dart';

class TaskFirebaseRepositoryImpl implements TaskFirebaseRepository{
  final TaskFirebaseDataSource taskFirebaseDataSource;

  TaskFirebaseRepositoryImpl({required this.taskFirebaseDataSource});

  @override
  Future<void> addTask(TaskEntity taskEntity) async{

    taskFirebaseDataSource.addTask(taskEntity);
  }

}