import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/usecases/edit_plan_usecase.dart';

part 'edit_plan_state.dart';

class EditPlanCubit extends Cubit<EditPlanState> {
  final EditPlanUsecase editPlanUsecase;
  EditPlanCubit({required this.editPlanUsecase}) : super(EditPlanInitial());

  Future<void> submitUpdatePlan(PlanEntity updatePlan) async {
    try {
      emit(EditPlanLoading());
      await editPlanUsecase.execute(updatePlan);
      emit(EditPlanSuccess());
    } catch (_) {
      emit(EditPlanFailure(message: 'Failed Edit Plan'));
    }
  }
}
