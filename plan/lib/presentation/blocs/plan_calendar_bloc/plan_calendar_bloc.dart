import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/usecases/get_plan_usecase.dart';

part 'plan_calendar_event.dart';
part 'plan_calendar_state.dart';

class PlanCalendarBloc extends Bloc<PlanCalendarEvent, PlanCalendarState> {
  final GetPlanUsecase getPlanUsecase;

  PlanCalendarBloc({required this.getPlanUsecase})
      : super(PlanCalendarInitial()) {
    on<GetPlanCalendarEvent>((event, emit) {
      List<PlanEntity> list = event.listPlan;
      list.sort((a, b) => a.time!.toDate().compareTo(b.time!.toDate()));
      emit(PlanCalendarSuccess(listPlan: list));
    });
    on<FetchPlanCalendarEvent>(
      (event, emit) async {
        emit(PlanCalendarLoading());
        try {
          getPlanUsecase.execute(event.petId, event.choiceDate).listen((task) {
            add(GetPlanCalendarEvent(listPlan: task));
          });
        } catch (_) {
          emit(PlanCalendarError(message: "error load data"));
        }
      },
    );
  }
}
