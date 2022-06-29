part of 'home_plan_calendar_bloc.dart';

abstract class HomePlanCalendarEvent extends Equatable {
  const HomePlanCalendarEvent();
  @override
  List<Object> get props => [];
}

class GetHomePlanCalendarEvent extends HomePlanCalendarEvent {
  final List<PlanEntity> listPlan;

  const GetHomePlanCalendarEvent({required this.listPlan});

  @override
  List<Object> get props => [listPlan];
}

class FetchHomePlanCalendarEvent extends HomePlanCalendarEvent {
  final String petId;
  final DateTime choiceDate;

  const FetchHomePlanCalendarEvent(
      {required this.petId, required this.choiceDate});

  @override
  List<Object> get props => [petId, choiceDate];
}

class ChangePlanStatusEvent extends HomePlanCalendarEvent {
  final String petId;
  final String planId;
  final DateTime choiceDate;

  const ChangePlanStatusEvent(this.petId, this.planId, this.choiceDate);

  @override
  List<Object> get props => [petId, planId, choiceDate];
}

class RemovePlanEvent extends HomePlanCalendarEvent {
  final String planId;
  final DateTime choiceDate;


  const RemovePlanEvent({required this.planId, required this.choiceDate});
  @override
  List<Object> get props => [planId, choiceDate];
}
