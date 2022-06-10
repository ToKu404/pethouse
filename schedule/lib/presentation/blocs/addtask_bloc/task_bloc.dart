import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/use_cases/task_add_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase addTaskUsecase;

  TaskBloc({required this.addTaskUsecase}) : super(TaskInitial()) {
    on<CreateTask>((event, emit) async {
      emit(TaskLoading());
      await addTaskUsecase.execute(event.taskEntity);
      emit(TaskSuccess());
    });
  }
}
