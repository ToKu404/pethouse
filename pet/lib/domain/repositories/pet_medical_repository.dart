
import 'package:pet/domain/entities/medical_entity.dart';

abstract class PetMedicalRepository{
  Stream<List<GetPetMedicalEntity>> getPetMedical(String pet_id);
}