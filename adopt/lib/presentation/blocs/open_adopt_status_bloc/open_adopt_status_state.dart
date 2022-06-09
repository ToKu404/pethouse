part of 'open_adopt_status_bloc.dart';

abstract class OpenAdoptStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class ActivityStatusInitial extends OpenAdoptStatusState {}

class ActivityStatusLoading extends OpenAdoptStatusState {}

class ActivityStatusError extends OpenAdoptStatusState {
  final String message;

  ActivityStatusError({required this.message});

  @override
  List<Object> get props => [message];
}

class ListOpenAdoptLoaded extends OpenAdoptStatusState {
  final List<AdoptEntity> adoptList;

  ListOpenAdoptLoaded({required this.adoptList});

  @override
  List<Object> get props => [adoptList];
}
