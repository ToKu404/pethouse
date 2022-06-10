part of 'get_schedule_pet_bloc.dart';

abstract class GetSchedulePetState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSchedulePetInitial extends GetSchedulePetState {}

class GetSchedulePetLoading extends GetSchedulePetState {}

class GetSchedulePetError extends GetSchedulePetState {
  final String message;
  GetSchedulePetError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetSchedulePetSuccess extends GetSchedulePetState {
  final List<PetEntity> listPet;

  GetSchedulePetSuccess({required this.listPet});

  
  @override
  List<Object> get props => [listPet];
}