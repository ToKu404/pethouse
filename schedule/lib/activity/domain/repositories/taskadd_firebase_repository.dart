import 'package:schedule/activity/domain/entities/task_entity.dart';

abstract class TaskFirebaseRepository{
  Future<void> addTask(TaskEntity taskEntity);
}