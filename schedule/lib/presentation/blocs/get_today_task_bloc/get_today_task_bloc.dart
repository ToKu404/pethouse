import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/use_cases/get_today_task_usecase.dart';

part 'get_today_task_event.dart';
part 'get_today_task_state.dart';

class GetTodayTaskBloc extends Bloc<GetTodayTaskEvent, GetTodayTaskState> {
  final GetTodayTaskUsecase getTodayTaskUsecase;
  GetTodayTaskBloc({required this.getTodayTaskUsecase})
      : super(GetTodayTaskInitial()) {
    on<GetTodayTasks>((event, emit) {
      List<TaskEntity> list = event.listPet;
      list.sort(
          (a, b) => a.startTime!.toDate().compareTo(b.startTime!.toDate()));
      emit(GetTodayTaskSuccess(listTask: list));
    });
    on<FetchTodayTask>(
      (event, emit) async {
        emit(GetTodayTaskLoading());
        try {
          getTodayTaskUsecase.execute(event.petId).listen((task) {
            add(GetTodayTasks(listPet: task));
          });
        } catch (_) {
          emit(GetTodayTaskError(message: "error load data"));
        }
      },
    );
  }
}
