part of 'add_plan_cubit.dart';

abstract class AddPlanState extends Equatable {
  const AddPlanState();
  @override
  List<Object> get props => [];
}

class AddPlanInitial extends AddPlanState {}

class AddPlanLoading extends AddPlanState {}

class AddPlanError extends AddPlanState {
  final String message;
  const AddPlanError(this.message);

  @override
  List<Object> get props => [message];
}

class AddPlanSucces extends AddPlanState {}
