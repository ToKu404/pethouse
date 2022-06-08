

import 'package:pet/domain/entities/medical_entity.dart';
import 'package:pet/domain/repositories/pet_firebase_repository.dart';

class GetAllMedicalUsecase {
  final PetFirebaseRepository petFirebaseRepository;
  GetAllMedicalUsecase({required this.petFirebaseRepository});

  Stream<List<MedicalEntity>> execute(){
    return petFirebaseRepository.getAllMedicalLists();
  }
}