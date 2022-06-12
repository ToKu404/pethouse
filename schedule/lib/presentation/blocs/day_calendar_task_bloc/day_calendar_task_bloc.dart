import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/get_today_task_usecase.dart';

part 'day_calendar_task_event.dart';
part 'day_calendar_task_state.dart';

class DayCalendarTaskBloc
    extends Bloc<DayCalendarTaskEvent, DayCalendarTaskState> {
  final GetTodayTaskUsecase getTodayTaskUsecase;

  DayCalendarTaskBloc({required this.getTodayTaskUsecase})
      : super(DayCalendarTaskInitial()) {
     on<GetDayTasks>((event, emit) {
      List<TaskEntity> list = event.listPet;
      list.sort(
          (a, b) => a.startTime!.toDate().compareTo(b.startTime!.toDate()));
      emit(DayCalendarTaskSuccess(listTask: list));
    });
    on<FetchChoiceDayTask>(
      (event, emit) async {
        emit(DayCalendarTaskLoading());
        try {
          getTodayTaskUsecase.execute(event.petId, event.choiceDate).listen((task) {
            add(GetDayTasks(listPet: task));
          });
        } catch (_) {
          emit(DayCalendarTaskError(message: "error load data"));
        }
      },
    );
  }
}
