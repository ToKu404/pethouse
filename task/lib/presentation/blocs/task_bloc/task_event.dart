part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object> get props => [];
}

class FetchTaskEvent extends TaskEvent {
  final String petId;
  const FetchTaskEvent({required this.petId});
  @override
  List<Object> get props => [petId];
}

class GetAllHabbits extends TaskEvent {
  final String petId;
  final List<HabbitEntity> listHabbit;
  const GetAllHabbits({required this.petId, required this.listHabbit});
  @override
  List<Object> get props => [petId];
}

class GetTaskEvent extends TaskEvent {
  final List<TaskEntity> tasks;
  const GetTaskEvent({required this.tasks});
  @override
  List<Object> get props => [tasks];
}

class ChangeTaskStatus extends TaskEvent {
  final String taskId;
  final String petId;

  const ChangeTaskStatus({required this.taskId, required this.petId});

  @override
  List<Object> get props => [taskId, petId];
}