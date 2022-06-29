import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan/domain/usecases/remove_plan_usecase.dart';
import 'package:plan/plan.dart';

part 'home_plan_calendar_event.dart';
part 'home_plan_calendar_state.dart';

class HomePlanCalendarBloc
    extends Bloc<HomePlanCalendarEvent, HomePlanCalendarState> {
  final GetPlanUsecase getPlanUsecase;
  final RemovePlanUsecase removePlanUsecase;
  final ChangePlanStatusUsecase changePlanStatusUsecase;

  HomePlanCalendarBloc(
      {required this.getPlanUsecase,
      required this.changePlanStatusUsecase,
      required this.removePlanUsecase})
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
    on<RemovePlanEvent>(
      (event, emit) async {
        await removePlanUsecase.execute(event.planId);
        emit(RemovePlanStatusSuccess());
        add(FetchHomePlanCalendarEvent(
            petId: event.planId, choiceDate: event.choiceDate));
      },
    );
  }
}
