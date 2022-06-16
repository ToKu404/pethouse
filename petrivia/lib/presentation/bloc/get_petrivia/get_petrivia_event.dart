part of 'get_petrivia_bloc.dart';

abstract class GetPetriviaEvent extends Equatable {
  const GetPetriviaEvent();

  @override
  List<Object> get props => [];
}

class GetListPetriviaEvent extends GetPetriviaEvent {
  final List<PetriviaEntity> listPetrivia;

  const GetListPetriviaEvent({required this.listPetrivia});

  @override
  List<Object> get props => [listPetrivia];
}

class FetchListPetriviaEvent extends GetPetriviaEvent{}