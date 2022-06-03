part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {

}

class TaskLoading extends TaskState{

}

class TaskError extends TaskState{
  final String message;
  TaskError(this.message);

  @override
  List<Object> get props =>[message];

}

class TaskSucces extends TaskState{

}