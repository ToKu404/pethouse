import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/plan_entity.dart';
import 'package:schedule/schedule.dart';

part 'add_plan_state.dart';

class AddPlanCubit extends Cubit<AddPlanState> {
  final AddPlanUsecase addPlanUsecase;
  AddPlanCubit({required this.addPlanUsecase}) : super(AddPlanInitial());

  Future<void> addPlan(PlanEntity planEntity) async {
    emit(AddPlanLoading());
    try {
      await addPlanUsecase.execute(planEntity);
      emit(AddPlanSucces());
    } catch (_) {
      emit(const AddPlanError('add plan error'));
    }
  }
}
