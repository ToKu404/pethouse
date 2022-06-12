part of 'day_calendar_task_bloc.dart';

abstract class DayCalendarTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class DayCalendarTaskInitial extends DayCalendarTaskState {}

class DayCalendarTaskLoading extends DayCalendarTaskState {}

class DayCalendarTaskError extends DayCalendarTaskState {
  final String message;
  DayCalendarTaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class DayCalendarTaskSuccess extends DayCalendarTaskState {
  final List<TaskEntity> listTask;

  

  DayCalendarTaskSuccess({required this.listTask});

  @override
  List<Object> get props => [listTask];
}