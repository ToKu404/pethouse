

import 'package:pet/domain/repositories/pet_medical_repository.dart';
import 'package:pet/domain/entities/medical_entity.dart';

class GetPetMedicalUsecase{
  final PetMedicalRepository petMedicalRepository;

  GetPetMedicalUsecase({required this.petMedicalRepository});

  Stream<List<GetPetMedicalEntity>> execute(String pet_id){
    return petMedicalRepository.getPetMedical(pet_id);
  }
}