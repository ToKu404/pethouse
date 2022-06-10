

import 'package:schedule/domain/entities/medical_entity.dart';
import 'package:schedule/domain/repositories/medicaladd_firebase_repository.dart';

class AddMedicalUseCase{
  final MedicalFirebaseRepository firebaseRepository;
  AddMedicalUseCase({required this.firebaseRepository});

  Future<void> execute(MedicalEntity medicalEntity) async{
    return firebaseRepository.addMedical(medicalEntity);
  }
}