part of 'request_adopt_status_bloc.dart';


abstract class RequestAdoptStatusEvent extends Equatable {
  const RequestAdoptStatusEvent();
  @override
  List<Object> get props => [];
}

class GetListRequestAdopt extends RequestAdoptStatusEvent {
  final List<AdoptEntity> listPet;

  const GetListRequestAdopt({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchListRequestAdopt extends RequestAdoptStatusEvent {}
