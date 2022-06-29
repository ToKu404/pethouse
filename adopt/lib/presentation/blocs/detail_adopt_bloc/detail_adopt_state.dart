part of 'detail_adopt_bloc.dart';

abstract class DetailAdoptState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailAdoptInitial extends DetailAdoptState {}

class DetailAdoptLoading extends DetailAdoptState {}

class DetailAdoptError extends DetailAdoptState {
  final String message;

  DetailAdoptError({required this.message});

  @override
  List<Object> get props => [message];
}

class PetDescriptionLoaded extends DetailAdoptState {
  final AdoptEntity adoptEntity;
  final bool isOwner;

  PetDescriptionLoaded({required this.adoptEntity, required this.isOwner});

  @override
  List<Object> get props => [adoptEntity, isOwner];
}

class SuccessRequestAdopt extends DetailAdoptState {}

class SuccessDisagreeRequestAdopt extends DetailAdoptState {}

class SuccessAgreeRequestAdopt extends DetailAdoptState {}

class RemoveAdoptSuccess extends DetailAdoptState {
  
}


