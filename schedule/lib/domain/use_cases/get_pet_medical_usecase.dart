
import '../entities/medical_entity.dart';
import '../repositories/medical_activity_repository.dart';

class GetPetMedicalUsecase{
  final MedicalActivityRepository petMedicalRepository;

  GetPetMedicalUsecase({required this.petMedicalRepository});

  Stream<List<MedicalEntity>> execute(String pet_id){
    return petMedicalRepository.getPetMedical(pet_id);
  }
} 