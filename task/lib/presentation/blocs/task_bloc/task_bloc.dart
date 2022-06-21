import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/use_cases/change_task_status_usecase.dart';
import 'package:task/domain/use_cases/get_one_read_task_usecase.dart';
import 'package:task/domain/use_cases/get_all_habbits_usecases.dart';
import 'package:task/domain/use_cases/get_today_task_usecase.dart';
import 'package:task/domain/use_cases/transfer_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetOneReadTaskUsecase getOneReadTaskUsecase;
  final TransferTaskUsecase transferTaskUsecase;
  final GetAllHabbitsUsecase getAllHabbitsUsecase;
  final GetTodayTaskUsecase getTodayTaskUsecase;
  final ChangeTaskStatusUsecase changeTaskStatus;
  TaskBloc({
    required this.getOneReadTaskUsecase,
    required this.transferTaskUsecase,
    required this.getAllHabbitsUsecase,
    required this.getTodayTaskUsecase,
    required this.changeTaskStatus,
  }) : super(TaskInitial()) {
    on<FetchTaskEvent>(
      (event, emit) async {
        emit(TaskLoading());
        getAllHabbitsUsecase.execute(event.petId).listen((habbit) {
          add(GetAllHabbits(petId: event.petId, listHabbit: habbit));
        });
      },
    );
    on<GetAllHabbits>(
      (event, emit) async {
        List<HabbitEntity> allHabbit = _checkMatchHabbit(event.listHabbit);
        final tasks =
            await getOneReadTaskUsecase.execute(DateTime.now(), event.petId);

        List<String> habbitsId = allHabbit.map((e) => e.id!).toList();
        List<String> taskId = tasks.map((e) => e.habbitId!).toList();

        List<HabbitEntity> habbitAdd = [];
        List<String> habbitRemove = [];

        for (var element in habbitsId) {
          if (!taskId.contains(element)) {
            habbitAdd.add(allHabbit.where((val) => val.id == element).first);
          }
        }

        for (var element in taskId) {
          if (!habbitsId.contains(element)) {
            habbitRemove
                .add(tasks.where((val) => val.habbitId == element).first.id!);
          }
        }
        await transferTaskUsecase.execute(habbitAdd, habbitRemove);
        getTodayTaskUsecase
            .execute(event.petId, DateTime.now())
            .listen((event) {
          add(GetTaskEvent(tasks: event));
        });
      },
    );
    on<GetTaskEvent>(
      (event, emit) {
        emit(GetTaskSuccess(listTask: event.tasks));
      },
    );
    on<ChangeTaskStatus>(
      (event, emit) async {
        await changeTaskStatus.execute(event.taskId);
        emit(ChangeTaskStatusSuccess());
        add(FetchTaskEvent(petId: event.petId));
      },
    );
  }

  _checkMatchHabbit(List<HabbitEntity> listHabbit) {
    List<HabbitEntity> matchHabbit = [];
    final df = DateFormat.yMMMEd();
    final dayNow = DateFormat.E().format(DateTime.now());

    for (var element in listHabbit) {
      if (df.format(element.time!.toDate()) == df.format(DateTime.now()) ||
          (element.time!.toDate().isBefore(DateTime.now()) &&
              element.dayRepeat!.contains(dayNow))) {
        matchHabbit.add(element);
      }
    }

    return matchHabbit;
  }
}
