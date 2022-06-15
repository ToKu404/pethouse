part of 'get_pet_medical_bloc.dart';

abstract class GetPetMedicalEvent extends Equatable {
  const GetPetMedicalEvent();

  @override
  List<Object> get props => [];
}

class GetListPetMedical extends GetPetMedicalEvent {
  final List<MedicalEntity> listPetMedical;

  GetListPetMedical({required this.listPetMedical});

  @override
  List<Object> get props => [listPetMedical];
}

class FetchListPetMedical extends GetPetMedicalEvent {
  final String petId;

  FetchListPetMedical({required this.petId});

  
  @override
  List<Object> get props => [petId];
}
