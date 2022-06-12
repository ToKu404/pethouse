part of 'day_calendar_task_bloc.dart';

abstract class DayCalendarTaskEvent extends Equatable {
  const DayCalendarTaskEvent();
  @override
  List<Object> get props => [];
}

class GetDayTasks extends DayCalendarTaskEvent {
  final List<TaskEntity> listPet;

  const GetDayTasks({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchChoiceDayTask extends DayCalendarTaskEvent {
  final String petId;
  final DateTime choiceDate;

  FetchChoiceDayTask({required this.petId, required this.choiceDate});

  @override
  List<Object> get props => [petId, choiceDate];
}
