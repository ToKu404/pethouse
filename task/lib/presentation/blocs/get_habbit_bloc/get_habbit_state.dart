part of 'get_habbit_bloc.dart';

abstract class GetHabbitState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetHabbitInitial extends GetHabbitState {}

class GetHabbitLoading extends GetHabbitState {}

class GetHabbitError extends GetHabbitState {
  final String message;
  GetHabbitError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetHabbitSuccess extends GetHabbitState {
  final List<HabbitEntity> listHabbit;

  GetHabbitSuccess({required this.listHabbit});

  @override
  List<Object> get props => [listHabbit];
}
