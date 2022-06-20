part of 'day_plan_calendar_bloc.dart';

abstract class DayPlanCalendarState extends Equatable {
  @override
  List<Object> get props => [];
}

class DayPlanCalendarInitial extends DayPlanCalendarState {}

class DayPlanCalendarLoading extends DayPlanCalendarState {}

class DayPlanCalendarError extends DayPlanCalendarState {
  final String message;
  DayPlanCalendarError({required this.message});

  @override
  List<Object> get props => [message];
}

class DayPlanCalendarSuccess extends DayPlanCalendarState {
  final List<PlanEntity> listPlan;

  DayPlanCalendarSuccess({required this.listPlan});

  @override
  List<Object> get props => [listPlan];
}
