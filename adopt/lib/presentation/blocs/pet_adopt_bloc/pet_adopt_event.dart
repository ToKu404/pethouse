part of 'pet_adopt_bloc.dart';

abstract class PetAdoptEvent extends Equatable {
  const PetAdoptEvent();
  @override
  List<Object> get props => [];
}

class SubmitOpenAdopt extends PetAdoptEvent {
  final AdoptEntity adoptEntity;

  const SubmitOpenAdopt({required this.adoptEntity});
}

class UploadPetPhoto extends PetAdoptEvent {}

class UploadPetCertificate extends PetAdoptEvent {}

