import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/use_cases/get_plan_history_usecase.dart';
import '../../../domain/entities/plan_entity.dart';

part 'get_plan_history_event.dart';
part 'get_plan_history_state.dart';

class GetPlanHistoryBloc
    extends Bloc<GetPlanHistoryEvent, GetPlanHistoryState> {
  final GetPlanHistoryUsecase getPlanHistoryUsecase;
  GetPlanHistoryBloc({required this.getPlanHistoryUsecase})
      : super(GetPlanHistoryInitial()) {
    on<GetPlanHistory>((event, emit) {
      emit(GetPlanHistorySuccess(listPlanHistory: event.listPlanHistory));
    });
    on<FetchPlanHistoryEvent>(
      (event, emit) async {
        emit(GetPlanHistoryLoading());
        try {
          getPlanHistoryUsecase.execute(event.petId).listen((planHistory) {
            add(GetPlanHistory(listPlanHistory: planHistory));
          });
        } catch (_) {
          emit(const GetPlanHistoryError(message: "error load data"));
        }
      },
    );
  }
}
