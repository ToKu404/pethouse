import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/repositories/pet_firebase_repository.dart';

class AddPetUseCase{
  final PetFirebaseRepository firebaseRepository;
  AddPetUseCase({required this.firebaseRepository});

  Future<void> execute(PetEntity petEntity) async{
    return firebaseRepository.addPet(petEntity);
  }
}