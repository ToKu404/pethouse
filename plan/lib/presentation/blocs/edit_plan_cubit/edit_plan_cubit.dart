import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/usecases/edit_plan_usecase.dart';

part 'edit_plan_state.dart';

class EditPlanCubit extends Cubit<EditPlanState> {
  final EditPlanUsecase editPlanUsecase;
  EditPlanCubit({required this.editPlanUsecase}) : super(EditPlanInitial());

  Future<void> submitUpdatePlan(
      PlanEntity updatePlan, PlanEntity oldPlan) async {
    try {
      emit(EditPlanLoading());
      PlanEntity newPlan = PlanEntity(
        id: oldPlan.id,
        date: updatePlan.date != oldPlan.date ? updatePlan.date : '',
        time: updatePlan.time != oldPlan.time ? updatePlan.time : null,
        activity:
            updatePlan.activity != oldPlan.activity ? updatePlan.activity : '',
        activityTitle: updatePlan.activityTitle != oldPlan.activityTitle
            ? updatePlan.activityTitle
            : '',
        location:
            updatePlan.location != oldPlan.location ? updatePlan.location : '',
        description: updatePlan.description != oldPlan.description
            ? updatePlan.description
            : '',
        reminder: updatePlan.reminder != oldPlan.reminder
            ? updatePlan.reminder
            : null,
        completeStatus: updatePlan.completeStatus != oldPlan.completeStatus
            ? updatePlan.completeStatus
            : null,
      );
      await editPlanUsecase.execute(newPlan);
      emit(EditPlanSuccess());
    } catch (_) {
      emit(EditPlanFailure(message: 'Failed Edit Plan'));
    }
  }
}
