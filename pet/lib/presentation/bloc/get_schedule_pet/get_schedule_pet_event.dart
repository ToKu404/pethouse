part of 'get_schedule_pet_bloc.dart';

abstract class GetSchedulePetEvent extends Equatable {
  const GetSchedulePetEvent();
  @override
  List<Object> get props => [];
}

class GetScheduleListPet extends GetSchedulePetEvent {
  final List<PetEntity> listPet;

  const GetScheduleListPet({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchListSchedulePet extends GetSchedulePetEvent {}
