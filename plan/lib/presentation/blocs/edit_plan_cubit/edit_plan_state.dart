part of 'edit_plan_cubit.dart';

abstract class EditPlanState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditPlanInitial extends EditPlanState {}

class EditPlanLoading extends EditPlanState {}

class EditPlanSuccess extends EditPlanState {}

class EditPlanFailure extends EditPlanState {
  final String message;
  EditPlanFailure({required this.message});

  @override
  List<Object> get props => [message];
}
