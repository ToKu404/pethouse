part of 'detail_adopt_bloc.dart';

abstract class DetailAdoptEvent extends Equatable {
  const DetailAdoptEvent();
  @override
  List<Object> get props => [];
}

class FetchPetDescription extends DetailAdoptEvent {
  final String petId;
  const FetchPetDescription({required this.petId});
  @override
  List<Object> get props => [petId];
}

class GetPetDescription extends DetailAdoptEvent {
  final AdoptEntity adoptEntity;
  const GetPetDescription({required this.adoptEntity});
  @override
  List<Object> get props => [adoptEntity];
}

class RequestAdopt extends DetailAdoptEvent {
  final AdoptEntity adoptEntity;
  const RequestAdopt({required this.adoptEntity});
  @override
  List<Object> get props => [adoptEntity];
}

class DisagreeRequestAdopt extends DetailAdoptEvent {
  final AdoptEntity adoptEntity;
  const DisagreeRequestAdopt({required this.adoptEntity});
  @override
  List<Object> get props => [adoptEntity];
}


class AgreeRequestAdopt extends DetailAdoptEvent {
  final AdoptEntity adoptEntity;
  const AgreeRequestAdopt({required this.adoptEntity});
  @override
  List<Object> get props => [adoptEntity];
}

class RemoveOpenAdoptEvent extends DetailAdoptEvent {
  final String adoptId;

  const RemoveOpenAdoptEvent({required this.adoptId});

    @override
  List<Object> get props => [adoptId];
}