import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/use_cases/task_add_usecase.dart';
import 'package:schedule/presentation/blocs/addmedical_bloc/medical_bloc.dart';


part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase addTaskUsecase;


  TaskBloc({required this.addTaskUsecase}) : super(TaskInitial()) {
    on<CreateTask>((event, emit) async {
      // TODO: implement event handler
      emit(TaskLoading());
      await addTaskUsecase.execute(event.taskEntity);
      emit(TaskSucces());

    });
  }
}
