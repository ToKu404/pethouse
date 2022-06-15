import 'package:schedule/domain/entities/medical_entity.dart';
import 'package:schedule/domain/repositories/medical_activity_repository.dart';

class AddMedicalUseCase {
  final MedicalActivityRepository firebaseRepository;
  AddMedicalUseCase({required this.firebaseRepository});

  Future<void> execute(MedicalEntity medicalEntity) async {
    return firebaseRepository.addMedical(medicalEntity);
  }
}
