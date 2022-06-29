part of 'request_adopt_status_bloc.dart';

abstract class RequestAdoptStatusState extends Equatable{
   @override
  List<Object> get props => [];
}

class RequestAdoptStatusInitial extends RequestAdoptStatusState {
  
}


class RequestAdoptStatusLoading extends RequestAdoptStatusState {}

class RequestAdoptStatusError extends RequestAdoptStatusState {
  final String message;

  RequestAdoptStatusError({required this.message});

  @override
  List<Object> get props => [message];
}

class ListRequestAdoptLoaded extends RequestAdoptStatusState {
  final List<AdoptEntity> adoptList;

  ListRequestAdoptLoaded({required this.adoptList});

  @override
  List<Object> get props => [adoptList];
}

