import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/use_cases/get_monthly_task_usecase.dart';

import '../../../domain/entities/task_entity.dart';

part 'get_monthly_task_event.dart';
part 'get_monthly_task_state.dart';

class GetMonthlyTaskBloc
    extends Bloc<GetMonthlyTaskEvent, GetMonthlyTaskState> {
  final GetMonthlyTaskUsecase getMonthlyTaskUsecase;
  GetMonthlyTaskBloc({required this.getMonthlyTaskUsecase})
      : super(GetMonthlyTaskInitial()) {
    on<GetMonthlyTasks>((event, emit) {
      List<TaskEntity> list = event.listPet;
      list.sort(
          (a, b) => a.time!.toDate().compareTo(b.time!.toDate()));
      emit(GetMonthlyTaskSuccess(listTask: list));
    });
    on<FetchMonthlyTask>(
      (event, emit) async {
        emit(GetMonthlyTaskLoading());
        try {
          DateTime firstDayCurrentMonth = DateTime.utc(
              DateTime.now().year, DateTime.now().month, 1, 00, 00);
          DateTime lastDayCurrentMonth = DateTime.utc(DateTime.now().year,
              DateTime.now().month, DateTime.now().day, 23, 59);
          getMonthlyTaskUsecase
              .execute(event.petId, firstDayCurrentMonth, lastDayCurrentMonth)
              .listen((task) {
            print(task);
            add(GetMonthlyTasks(listPet: task));
          });
        } catch (_) {
          emit(GetMonthlyTaskError(message: "error load data"));
        }
      },
    );
  }
}
