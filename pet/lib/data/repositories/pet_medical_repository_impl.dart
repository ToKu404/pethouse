
import 'package:pet/data/data_sources/pet_medical_data_source.dart';
import 'package:pet/domain/entities/medical_entity.dart';
import 'package:pet/domain/repositories/pet_medical_repository.dart';
import 'package:schedule/domain/entities/medical_entity.dart';

class PetMedicalRepositoryImpl extends PetMedicalRepository{
  final PetMedicalDataSource petMedicalDataSource;
  PetMedicalRepositoryImpl({required this.petMedicalDataSource});

  @override
  Stream<List<GetPetMedicalEntity>> getPetMedical(String pet_id) {
    return petMedicalDataSource.getPetMedical(pet_id);
  }
}