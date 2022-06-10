part of 'get_today_task_bloc.dart';

abstract class GetTodayTaskEvent extends Equatable {
  const GetTodayTaskEvent();
  @override
  List<Object> get props => [];
}

class GetTodayTasks extends GetTodayTaskEvent {
  final List<TaskEntity> listPet;

  const GetTodayTasks({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchTodayTask extends GetTodayTaskEvent {
  final String petId;

  FetchTodayTask({required this.petId});

    @override
  List<Object> get props => [petId];
}
