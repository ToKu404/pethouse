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
