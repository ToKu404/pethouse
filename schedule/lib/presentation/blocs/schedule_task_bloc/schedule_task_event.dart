part of 'schedule_task_bloc.dart';

abstract class ScheduleTaskEvent extends Equatable {
  const ScheduleTaskEvent();
  @override
  List<Object> get props => [];
}

class GetScheduleTaskEvent extends ScheduleTaskEvent {
  final bool value;
  final String date;

  const GetScheduleTaskEvent({required this.value, required this.date});

  @override
  List<Object> get props => [value, date];
}

class EnableDailyNotifEvent extends ScheduleTaskEvent {
  final bool value;

  const EnableDailyNotifEvent({required this.value});

  @override
  List<Object> get props => [value];
}
