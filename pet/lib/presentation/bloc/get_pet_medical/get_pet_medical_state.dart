part of 'get_pet_medical_bloc.dart';

abstract class GetPetMedicalState extends Equatable {
  const GetPetMedicalState();
  @override
  List<Object> get props => [];
}

class GetPetMedicalInitial extends GetPetMedicalState {}

class GetPetMedicalLoading extends GetPetMedicalState {}

class GetPetMedicalError extends GetPetMedicalState {
  final String message;
  GetPetMedicalError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetPetMedicalSucces extends GetPetMedicalState {
  final List<GetPetMedicalEntity> listPetMedical;
  GetPetMedicalSucces({required this.listPetMedical});

  @override
  List<Object> get props => [listPetMedical];

}


