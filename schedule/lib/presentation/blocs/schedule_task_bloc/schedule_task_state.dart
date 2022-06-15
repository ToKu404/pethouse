part of 'schedule_task_bloc.dart';

abstract class ScheduleTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScheduleTaskInitial extends ScheduleTaskState {}

class GetScheduleTaskState extends ScheduleTaskState {
  final bool value;

  GetScheduleTaskState({required this.value});

    @override
  List<Object> get props => [value];
}

class EnableDailyNotifSuccess extends ScheduleTaskState {
  
}
