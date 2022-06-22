import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/domain/usecases/get_plan_usecase.dart';
import 'package:plan/plan.dart';

part 'home_plan_calendar_event.dart';
part 'home_plan_calendar_state.dart';

class HomePlanCalendarBloc
    extends Bloc<HomePlanCalendarEvent, HomePlanCalendarState> {
  final GetPlanUsecase getPlanUsecase;
  final ChangePlanStatusUsecase changePlanStatusUsecase;

  HomePlanCalendarBloc(
      {required this.getPlanUsecase, required this.changePlanStatusUsecase})
      : super(HomePlanCalendarInitial()) {
    on<GetHomePlanCalendarEvent>((event, emit) {
      List<PlanEntity> list = event.listPlan;
      list.sort((a, b) => a.time!.toDate().compareTo(b.time!.toDate()));
      emit(HomePlanCalendarSuccess(listPlan: list));
    });
    on<FetchHomePlanCalendarEvent>(
      (event, emit) async {
        emit(HomePlanCalendarLoading());
        try {
          getPlanUsecase.execute(event.petId, event.choiceDate).listen((task) {
            add(GetHomePlanCalendarEvent(listPlan: task));
          });
        } catch (_) {
          emit(HomePlanCalendarError(message: "error load data"));
        }
      },
    );
    on<ChangePlanStatusEvent>(
      (event, emit) async {
        print(event.planId);
        await changePlanStatusUsecase.execute(event.planId);
        emit(ChangePlanStatusSuccess());
        add(FetchHomePlanCalendarEvent(
            petId: event.petId, choiceDate: event.choiceDate));
      },
    );
  }
}
