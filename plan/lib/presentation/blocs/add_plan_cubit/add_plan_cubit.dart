import 'package:core/services/notification_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/usecases/get_plan_notif_id_usecase.dart';

import '../../../domain/entities/plan_entity.dart';
import '../../../domain/usecases/add_plan_usecase.dart';
part 'add_plan_state.dart';

class AddPlanCubit extends Cubit<AddPlanState> {
  final AddPlanUsecase addPlanUsecase;
  final GetPlanNotifIdUsecase getPlanNotifIdUsecase;
  final NotificationHelper notificationHelper;
  AddPlanCubit(
      {required this.addPlanUsecase,
      required this.getPlanNotifIdUsecase,
      required this.notificationHelper})
      : super(AddPlanInitial());

  Future<void> addPlan(PlanEntity planEntity) async {
    emit(AddPlanLoading());
    try {
      int notifId = 1;

      if (planEntity.reminder!) {
        final date = planEntity.time!.toDate();
        final planDateTime =
            DateTime(date.year, date.month, date.day, date.hour, date.minute);
        final listNotifId = await getPlanNotifIdUsecase.execute(
            planEntity.petId!, DateTime.now());
        while (listNotifId.contains(notifId)) {
          notifId++;
        }
        await notificationHelper.showNotifications(
            notifId,
            planEntity.activityTitle ?? '',
            planEntity.description ?? '',
            DateTime.parse("$planDateTime"));
      }
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

      await addPlanUsecase.execute(newPlan);
      emit(AddPlanSucces());
    } catch (_) {
      emit(const AddPlanError('add plan error'));
    }
  }
}
