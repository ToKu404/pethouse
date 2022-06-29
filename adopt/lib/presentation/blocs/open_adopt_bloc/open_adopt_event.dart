part of 'open_adopt_bloc.dart';

abstract class OpenAdoptEvent extends Equatable {
  const OpenAdoptEvent();
  @override
  List<Object> get props => [];
}

class OpenAdoptInit extends OpenAdoptEvent {}

class SubmitOpenAdopt extends OpenAdoptEvent {
  final AdoptEntity adoptEntity;

  const SubmitOpenAdopt({required this.adoptEntity});

    @override
  List<Object> get props => [adoptEntity];
}

class UploadPetPhoto extends OpenAdoptEvent {}

class UploadPetCertificate extends OpenAdoptEvent {}


