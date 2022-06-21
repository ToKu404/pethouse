part of 'get_monthly_task_bloc.dart';

abstract class GetMonthlyTaskEvent extends Equatable {
  const GetMonthlyTaskEvent();
  @override
  List<Object> get props => [];
}

class GetMonthlyTasks extends GetMonthlyTaskEvent {
  final List<TaskEntity> listPet;

  const GetMonthlyTasks({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchMonthlyTask extends GetMonthlyTaskEvent {
  final String petId;

  FetchMonthlyTask({required this.petId});

  @override
  List<Object> get props => [petId];
}
