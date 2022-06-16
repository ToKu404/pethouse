part of 'get_petrivia_bloc.dart';

abstract class GetPetriviaState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPetriviaInitial extends GetPetriviaState {}

class GetPetriviaLoading extends GetPetriviaState {}

class GetPetriviaError extends GetPetriviaState {
  final String message;

  GetPetriviaError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetPetriviaSuccess extends GetPetriviaState {
  final List<PetriviaEntity> listPetrivia;

  GetPetriviaSuccess({required this.listPetrivia});

  @override
  List<Object> get props => [listPetrivia];
}
