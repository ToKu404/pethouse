part of 'add_pet_bloc.dart';

abstract class AddPetState extends Equatable {
  const AddPetState();
  @override
  List<Object> get props => [];
}


class AddPetInitial extends AddPetState {}

class AddPetLoading extends AddPetState {}

class AddPetError extends AddPetState {
  final String message;
  AddPetError(this.message);

  @override
  List<Object> get props => [message];
}

class AddPetSucces extends AddPetState {}

class UpPhotoSucces extends AddPetState {
  final String imgUrl;

  UpPhotoSucces(this.imgUrl);
  @override
  List<Object> get props => [imgUrl];
}

class UpCertificateSucces extends AddPetState {
  final String ctfUrl;

  UpCertificateSucces(this.ctfUrl);
  @override
  List<Object> get props => [ctfUrl];
}



