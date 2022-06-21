part of 'get_plan_history_bloc.dart';

abstract class GetPlanHistoryEvent extends Equatable {
  const GetPlanHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetPlanHistory extends GetPlanHistoryEvent {
  final List<PlanEntity> listPlanHistory;

  const GetPlanHistory({required this.listPlanHistory});

  @override
  List<Object> get props => [listPlanHistory];
}

class FetchPlanHistoryEvent extends GetPlanHistoryEvent {
  final String petId;

  const FetchPlanHistoryEvent({required this.petId});

  @override
  List<Object> get props => [petId];
}
