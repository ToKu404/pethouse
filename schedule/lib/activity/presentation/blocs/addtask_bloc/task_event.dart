part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];

}

class CreateTask extends TaskEvent{
  final TaskEntity taskEntity;
  CreateTask({required this.taskEntity});
  @override
  List<Object> get props => [taskEntity];
}
