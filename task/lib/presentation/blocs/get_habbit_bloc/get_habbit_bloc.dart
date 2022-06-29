import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/domain/use_cases/get_all_habbits_usecases.dart';
import '../../../domain/entities/habbit_entity.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/get_one_read_habbit_usecase.dart';
import '../../../domain/use_cases/get_one_read_task_usecase.dart';
import '../../../domain/use_cases/transfer_task_usecase.dart';

part 'get_habbit_event.dart';
part 'get_habbit_state.dart';

class GetHabbitBloc extends Bloc<GetHabbitEvent, GetHabbitState> {
  final GetAllHabbitsUsecase getHabbitUsecase;
  final TransferTaskUsecase transferTaskUsecase;
  final GetOneReadTaskUsecase getOneReadTaskUsecase;

  GetHabbitBloc(
      {required this.getHabbitUsecase,
      required this.getOneReadTaskUsecase,
      required this.transferTaskUsecase})
      : super(GetHabbitInitial()) {
    on<GetHabbits>(
      (event, emit) async {
        final tasks =
            await getOneReadTaskUsecase.execute(DateTime.now(), event.petId);
        _transferHabbitTask(event.listHabbit, tasks);

        emit(GetHabbitSuccess(listHabbit: event.listHabbit));
      },
    );
    on<FetchHabbits>(
      (event, emit) {
        emit(GetHabbitLoading());
        try {
          getHabbitUsecase.execute(event.petId).listen((task) {
            add(GetHabbits(listHabbit: task, petId: event.petId));
          });
        } catch (_) {
          emit(GetHabbitError(message: "error load data"));
        }
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
}
