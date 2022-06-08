part of 'edit_adopt_bloc.dart';

abstract class EditAdoptEvent extends Equatable {
  const EditAdoptEvent();
  @override
  List<Object> get props => [];
}

class SubmitUpdateAdopt extends EditAdoptEvent {
  final AdoptEntity adoptEntityNew;
  final AdoptEntity adoptEntityOld;

  const SubmitUpdateAdopt(
      {required this.adoptEntityNew, required this.adoptEntityOld});
}

class EditPetPhoto extends EditAdoptEvent {
}

class EditPetCertificate extends EditAdoptEvent {
}

