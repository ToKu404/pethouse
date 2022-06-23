import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/usecases/get_plan_notif_id_usecase.dart';

import '../../../domain/entities/plan_entity.dart';
import '../../../domain/usecases/add_plan_usecase.dart';
part 'add_plan_state.dart';

class AddPlanCubit extends Cubit<AddPlanState> {
  final AddPlanUsecase addPlanUsecase;
  final GetPlanNotifIdUsecase getPlanNotifIdUsecase;
  AddPlanCubit(
      {required this.addPlanUsecase, required this.getPlanNotifIdUsecase})
      : super(AddPlanInitial());

  Future<void> addPlan(PlanEntity planEntity) async {
    emit(AddPlanLoading());
    try {
      final notifId = await generatePlanId(planEntity.petId!);
      final newPlan = PlanEntity(
          date: planEntity.date,
          time: planEntity.time,
          activity: planEntity.activity,
          activityTitle: planEntity.activityTitle,
          location: planEntity.location,
          description: planEntity.description,
          reminder: planEntity.reminder,
          completeStatus: planEntity.completeStatus,
          id: planEntity.id,
          notifId: notifId,
          petId: planEntity.petId);
      await addPlanUsecase.execute(planEntity);
      emit(AddPlanSucces(newPlan));
    } catch (_) {
      emit(const AddPlanError('add plan error'));
    }
  }

  generatePlanId(String petId) async {
    final listNotifId = await getPlanNotifIdUsecase.execute(petId);
    int i = 1;
    while (listNotifId.contains(i)) {
      i++;
    }
    return i;
  }
}
