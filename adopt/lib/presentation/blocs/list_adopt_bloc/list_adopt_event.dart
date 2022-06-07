part of 'list_adopt_bloc.dart';

abstract class ListAdoptEvent extends Equatable {
    const ListAdoptEvent();
  @override
  List<Object> get props => [];
}


class GetListPetAdopt extends ListAdoptEvent {
  final List<AdoptEntity> listPet;

  const GetListPetAdopt({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchListPetAdopt extends ListAdoptEvent {}
