part of 'get_today_task_bloc.dart';

abstract class GetTodayTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTodayTaskInitial extends GetTodayTaskState {}

class GetTodayTaskLoading extends GetTodayTaskState {}

class GetTodayTaskError extends GetTodayTaskState {
  final String message;
  GetTodayTaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetTodayTaskSuccess extends GetTodayTaskState {
  final List<TaskEntity> listTask;

  

  GetTodayTaskSuccess({required this.listTask});

  @override
  List<Object> get props => [listTask];
}
