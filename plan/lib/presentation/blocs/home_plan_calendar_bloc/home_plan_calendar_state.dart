part of 'home_plan_calendar_bloc.dart';

abstract class HomePlanCalendarState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomePlanCalendarInitial extends HomePlanCalendarState {}

class HomePlanCalendarLoading extends HomePlanCalendarState {}

class HomePlanCalendarError extends HomePlanCalendarState {
  final String message;
  HomePlanCalendarError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomePlanCalendarSuccess extends HomePlanCalendarState {
  final List<PlanEntity> listPlan;

  HomePlanCalendarSuccess({required this.listPlan});

  @override
  List<Object> get props => [listPlan];
}

class ChangePlanStatusSuccess extends HomePlanCalendarState {}
