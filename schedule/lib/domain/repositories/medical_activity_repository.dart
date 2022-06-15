import 'package:schedule/domain/entities/medical_entity.dart';

abstract class MedicalActivityRepository {
  Future<void> addMedical(MedicalEntity medicalEntity);
  Stream<List<MedicalEntity>> getPetMedical(String petId);
}
