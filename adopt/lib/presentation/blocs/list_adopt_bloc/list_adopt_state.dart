part of 'list_adopt_bloc.dart';

abstract class ListAdoptState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListAdoptInitial extends ListAdoptState {}

class ListAdoptLoading extends ListAdoptState {}

class ListAdoptError extends ListAdoptState {
  final String message;

  ListAdoptError({required this.message});

  @override
  List<Object> get props => [message];
}

class ListPetAdoptLoaded extends ListAdoptState {
  final List<AdoptEntity> listAdoptEntity;

  ListPetAdoptLoaded({required this.listAdoptEntity});

  @override
  List<Object> get props => [listAdoptEntity];
}
