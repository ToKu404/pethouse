part of 'habbit_cubit.dart';

abstract class HabbitState extends Equatable {
  const HabbitState();
  @override
  List<Object> get props => [];
}

class HabbitInitial extends HabbitState {}

class HabbitLoading extends HabbitState {}

class AddHabbitFailure extends HabbitState {
  final String message;

  const AddHabbitFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class AddHabbitSuccess extends HabbitState {}

class RemoveHabbitFailure extends HabbitState {
  final String message;

  const RemoveHabbitFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class RemoveHabbitSuccess extends HabbitState {}
