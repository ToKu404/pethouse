import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/usecases/get_plan_usecase.dart';


part 'day_plan_calendar_event.dart';
part 'day_plan_calendar_state.dart';

class DayPlanCalendarBloc
    extends Bloc<DayPlanCalendarEvent, DayPlanCalendarState> {
  final GetPlanUsecase getPlanUsecase;

  DayPlanCalendarBloc({required this.getPlanUsecase})
      : super(DayPlanCalendarInitial()) {
    on<GetPlanCalendarEvent>((event, emit) {
      List<PlanEntity> list = event.listPlan;
      list.sort(
          (a, b) => a.time!.toDate().compareTo(b.time!.toDate()));
      emit(DayPlanCalendarSuccess(listPlan: list));
    });
    on<FetchPlanCalendarEvent>(
      (event, emit) async {
        emit(DayPlanCalendarLoading());
        try {
          getPlanUsecase.execute(event.petId, event.choiceDate).listen((task) {
            add(GetPlanCalendarEvent(listPlan: task));
          });
        } catch (_) {
          emit(DayPlanCalendarError(message: "error load data"));
        }
      },
    );
  }
}
