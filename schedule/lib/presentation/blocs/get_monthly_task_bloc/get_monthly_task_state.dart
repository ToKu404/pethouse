part of 'get_monthly_task_bloc.dart';

abstract class GetMonthlyTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMonthlyTaskInitial extends GetMonthlyTaskState {}

class GetMonthlyTaskLoading extends GetMonthlyTaskState {}

class GetMonthlyTaskError extends GetMonthlyTaskState {
  final String message;
  GetMonthlyTaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetMonthlyTaskSuccess extends GetMonthlyTaskState {
  final List<TaskEntity> listTask;

  GetMonthlyTaskSuccess({required this.listTask});

  @override
  List<Object> get props => [listTask];
}
