part of 'plan_calendar_bloc.dart';

abstract class PlanCalendarState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlanCalendarInitial extends PlanCalendarState {}

class PlanCalendarLoading extends PlanCalendarState {}

class PlanCalendarError extends PlanCalendarState {
  final String message;
  PlanCalendarError({required this.message});

  @override
  List<Object> get props => [message];
}

class PlanCalendarSuccess extends PlanCalendarState {
  final List<PlanEntity> listPlan;

  PlanCalendarSuccess({required this.listPlan});

  @override
  List<Object> get props => [listPlan];
}
