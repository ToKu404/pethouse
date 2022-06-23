part of 'plan_calendar_bloc.dart';

abstract class PlanCalendarEvent extends Equatable {
  const PlanCalendarEvent();
  @override
  List<Object> get props => [];
}

class GetPlanCalendarEvent extends PlanCalendarEvent {
  final List<PlanEntity> listPlan;

  const GetPlanCalendarEvent({required this.listPlan});

  @override
  List<Object> get props => [listPlan];
}

class FetchPlanCalendarEvent extends PlanCalendarEvent {
  final String petId;
  final DateTime choiceDate;

  const FetchPlanCalendarEvent({required this.petId, required this.choiceDate});

  @override
  List<Object> get props => [petId, choiceDate];
}
