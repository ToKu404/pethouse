part of 'get_plan_history_bloc.dart';

abstract class GetPlanHistoryState extends Equatable {
  const GetPlanHistoryState();
  @override
  List<Object> get props => [];
}

class GetPlanHistoryInitial extends GetPlanHistoryState {}

class GetPlanHistoryLoading extends GetPlanHistoryState {}

class GetPlanHistoryError extends GetPlanHistoryState {
  final String message;
  const GetPlanHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetPlanHistorySuccess extends GetPlanHistoryState {
  final List<PlanEntity> listPlanHistory;
  const GetPlanHistorySuccess({required this.listPlanHistory});

  @override
  List<Object> get props => [listPlanHistory];
}
