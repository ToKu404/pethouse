part of 'open_adopt_status_bloc.dart';

abstract class OpenAdoptStatusEvent extends Equatable {
  const OpenAdoptStatusEvent();
  @override
  List<Object> get props => [];
}

class GetListOpenAdopt extends OpenAdoptStatusEvent {
  final List<AdoptEntity> listPet;

  const GetListOpenAdopt({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchListOpenAdopt extends OpenAdoptStatusEvent {}
