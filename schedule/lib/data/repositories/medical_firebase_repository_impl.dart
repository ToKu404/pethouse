

import 'package:schedule/data/data_sources/medical_firebase_data_source.dart';
import 'package:schedule/domain/entities/medical_entity.dart';
import 'package:schedule/domain/repositories/medicaladd_firebase_repository.dart';

class MedicalFirebaseRepositoryImpl implements MedicalFirebaseRepository{
  final MedicalFirebaseDataSource medicalFirebaseDataSource;

  MedicalFirebaseRepositoryImpl({required this.medicalFirebaseDataSource});

  @override
  Future<void> addMedical(MedicalEntity medicalEntity) async{

    medicalFirebaseDataSource.addMedical(medicalEntity);
  }

}