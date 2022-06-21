part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
  @override
  List<Object> get props => [message];
}

class GetTaskSuccess extends TaskState {
  final List<TaskEntity> listTask;

  GetTaskSuccess({required this.listTask});

    @override
  List<Object> get props => [listTask];
}

class ChangeTaskStatusSuccess extends TaskState {}