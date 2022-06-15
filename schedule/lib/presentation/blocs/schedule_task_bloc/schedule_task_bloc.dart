import 'package:bloc/bloc.dart';
import 'package:core/services/preference_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:schedule/domain/use_cases/schedule_task_usecase.dart';

part 'schedule_task_event.dart';
part 'schedule_task_state.dart';

class ScheduleTaskBloc extends Bloc<ScheduleTaskEvent, ScheduleTaskState> {
  final ScheduleTaskUsecase scheduleTaskUsecase;
  ScheduleTaskBloc(
      {required this.scheduleTaskUsecase})
      : super(ScheduleTaskInitial()) {
    on<GetScheduleTaskEvent>((event, emit) async {
      final result = await scheduleTaskUsecase.execute(event.value, event.date);
      emit(GetScheduleTaskState(value: result));
    });
  }
}
