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
  final GetOneReadTaskUsecase getOneReadTaskUsecase;
  final TransferTaskUsecase transferTaskUsecase;
  final GetOneReadHabbitUsecase getOneReadHabbitUsecase;
  final GetAllHabbitsUsecase getAllHabbitsUsecase;
  final GetTodayTaskUsecase getTodayTaskUsecase;
  final ChangeTaskStatusUsecase changeTaskStatus;
  TaskBloc({
    required this.getOneReadHabbitUsecase,
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
        //  Mendapatkan tasks hari ini
        final tasks = await getOneReadTaskUsecase.execute(DateTime.now(), event.petId);
        // Mendapatkan habbit yang cocok dengan hari ini
        List<HabbitEntity> allHabbit = _checkMatchHabbit(event.listHabbit);

        // Mendapatkan semua habbit id dari all habbit
        List<String> habbitsId = allHabbit.map((e) => e.id!).toList();
        print("TODAY Habbit $habbitsId");
        // Mendapatkan semua habbit id dari task hari ini
        List<String> habbitIdTasks = tasks.map((e) => e.habbitId!).toList();
        print("TODAY Tasks $habbitIdTasks");


        // list untuk habbit baru yang akan ditambahkan
        List<HabbitEntity> habbitAdd = [];
        // list task id yang akan diremove
        List<TaskEntity> taskIdRemove = [];

        // Mengecek id di habbit id
        for (var element in habbitsId) {
          // Jika dalam habbit id pada task tidak memuat id yg ada pada habbit id
          if (!habbitIdTasks.contains(element)) {
            // tambahkan habbit yang ber id tersebut ke dalam habbit add
            habbitAdd.add(allHabbit.where((val) => val.id == element).first);
          }
        }
        print("Habbit Add $habbitAdd");


        // Mengecek id habbit pada list task
        for (var element in habbitIdTasks) {
          // jika terdapat id didalamnya yang tidak terdapat pada habbits id
          if (!habbitsId.contains(element)) {
            // menambahkan id task yang memiliki id habbit tersebut ke id yang akan diremove
            for (var task in tasks) {
              if (task.habbitId == element) {
                taskIdRemove.add(task);
              }
            }
          }
          habbitsId.remove(element);
        }
        print("Habbit Remove $taskIdRemove");

        await transferTaskUsecase.execute(habbitAdd, taskIdRemove);

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
