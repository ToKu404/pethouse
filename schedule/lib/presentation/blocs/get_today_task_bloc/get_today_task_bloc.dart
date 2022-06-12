import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/use_cases/change_task_status_usecase.dart';
import 'package:schedule/domain/use_cases/get_today_task_usecase.dart';

part 'get_today_task_event.dart';
part 'get_today_task_state.dart';

class GetTodayTaskBloc extends Bloc<GetTodayTaskEvent, GetTodayTaskState> {
  final GetTodayTaskUsecase getTodayTaskUsecase;
  final ChangeTaskStatusUsecase changeTaskStatusUsecase;
  GetTodayTaskBloc(
      {required this.getTodayTaskUsecase,
      required this.changeTaskStatusUsecase})
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
          getTodayTaskUsecase.execute(event.petId, DateTime.now()).listen((task) {
            add(GetTodayTasks(listPet: task));
          });
        } catch (_) {
          emit(GetTodayTaskError(message: "error load data"));
        }
      },
    );
    on<ChangeTaskStatus>(
      (event, emit) async {
        await changeTaskStatusUsecase.execute(event.taskId);
        emit(ChangeTaskStatusSuccess());
        add(FetchTodayTask(petId: event.petId));
      },
    );
  }
}
