part of 'day_plan_calendar_bloc.dart';

abstract class DayPlanCalendarEvent extends Equatable {
  const DayPlanCalendarEvent();
  @override
  List<Object> get props => [];
}

class GetPlanCalendarEvent extends DayPlanCalendarEvent {
  final List<PlanEntity> listPlan;

  const GetPlanCalendarEvent({required this.listPlan});

  @override
  List<Object> get props => [listPlan];
}

class FetchPlanCalendarEvent extends DayPlanCalendarEvent {
  final String petId;
  final DateTime choiceDate;

  const FetchPlanCalendarEvent({required this.petId, required this.choiceDate});

  @override
  List<Object> get props => [petId, choiceDate];
}
