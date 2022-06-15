import 'package:schedule/data/data_sources/medical_firebase_data_source.dart';
import 'package:schedule/domain/entities/medical_entity.dart';
import 'package:schedule/domain/repositories/medical_activity_repository.dart';

class MedicalFirebaseRepositoryImpl implements MedicalActivityRepository {
  final MedicalFirebaseDataSource medicalFirebaseDataSource;

  MedicalFirebaseRepositoryImpl({required this.medicalFirebaseDataSource});

  @override
  Future<void> addMedical(MedicalEntity medicalEntity) async {
    medicalFirebaseDataSource.addMedical(medicalEntity);
  }

  @override
  Stream<List<MedicalEntity>> getPetMedical(String petId) {
    return medicalFirebaseDataSource.getPetMedical(petId);
  }
}
