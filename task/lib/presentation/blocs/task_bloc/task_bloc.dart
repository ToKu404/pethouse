import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/use_cases/change_task_status_usecase.dart';
import 'package:task/domain/use_cases/get_all_habbits_usecases.dart';
import 'package:task/domain/use_cases/get_one_read_habbit_usecase.dart';
import 'package:task/domain/use_cases/get_one_read_task_usecase.dart';
import 'package:task/domain/use_cases/get_today_task_usecase.dart';
import 'package:task/domain/use_cases/transfer_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TransferTaskUsecase transferTaskUsecase;
  final GetOneReadHabbitUsecase getOneReadHabbitUsecase;
  final GetTodayTaskUsecase getTodayTaskUsecase;
  final ChangeTaskStatusUsecase changeTaskStatus;
  TaskBloc({
    required this.getOneReadHabbitUsecase,
    required this.transferTaskUsecase,
    required this.getTodayTaskUsecase,
    required this.changeTaskStatus,
  }) : super(TaskInitial()) {
    on<FetchTaskEvent>(
      (event, emit) async {
        emit(TaskLoading());
        getTodayTaskUsecase
            .execute(event.petId, DateTime.now())
            .listen((tasks) {
          add(GetTaskEvent(tasks: tasks, petId: event.petId));
        });
      },
    );

    on<GetTaskEvent>(
      (event, emit) async {
        final habbits = await getOneReadHabbitUsecase.execute(event.petId);
        _transferHabbitTask(habbits, event.tasks);
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

  _transferHabbitTask(
      List<HabbitEntity> habbits, List<TaskEntity> tasks) async {
    List<HabbitEntity> allHabbit = _checkMatchHabbit(habbits);
    List<String> habbitsId = allHabbit.map((e) => e.id!).toList();
    List<String> habbitIdTasks = tasks.map((e) => e.habbitId!).toList();
    List<HabbitEntity> habbitAdd = [];
    List<TaskEntity> taskIdRemove = [];
    for (var element in habbitsId) {
      if (!habbitIdTasks.contains(element)) {
        habbitAdd.add(allHabbit.where((val) => val.id == element).first);
      }
    }
    for (var element in habbitIdTasks) {
      if (!habbitsId.contains(element)) {
        TaskEntity task =
            tasks.where((task) => task.habbitId == element).toList().first;
        tasks.remove(task);
        taskIdRemove.add(task);
      }
      habbitsId.remove(element);
    }
    await transferTaskUsecase.execute(habbitAdd, taskIdRemove);
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
