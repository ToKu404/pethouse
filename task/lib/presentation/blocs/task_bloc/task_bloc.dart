import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/use_cases/change_task_status_usecase.dart';
import 'package:task/domain/use_cases/check_task_exist_usecase.dart';
import 'package:task/domain/use_cases/get_all_habbits_usecases.dart';
import 'package:task/domain/use_cases/get_today_task_usecase.dart';
import 'package:task/domain/use_cases/transfer_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CheckTaskExistUsecase taskExistUsecase;
  final TransferTaskUsecase transferTaskUsecase;
  final GetAllHabbitsUsecase getAllHabbitsUsecase;
  final GetTodayTaskUsecase getTodayTaskUsecase;
  final ChangeTaskStatusUsecase changeTaskStatus;
  TaskBloc({
    required this.taskExistUsecase,
    required this.transferTaskUsecase,
    required this.getAllHabbitsUsecase,
    required this.getTodayTaskUsecase,
    required this.changeTaskStatus,
  }) : super(TaskInitial()) {
    on<FetchTaskEvent>(
      (event, emit) async {
        emit(TaskLoading());
        final isExist =
            await taskExistUsecase.execute(event.petId, DateTime.now());
        if (!isExist) {
          getAllHabbitsUsecase.execute(event.petId).listen((habbit) {
            add(GetAllHabbits(petId: event.petId, listHabbit: habbit));
          });
        }
        getTodayTaskUsecase
            .execute(event.petId, DateTime.now())
            .listen((event) {
          add(GetTaskEvent(tasks: event));
        });
      },
    );
    on<GetAllHabbits>(
      (event, emit) async {
        final allHabbit = _checkMatchHabbit(event.listHabbit);
        await transferTaskUsecase.execute(
            allHabbit, DateTime.now(), event.petId);
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
