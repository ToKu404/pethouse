import 'dart:io';

import 'package:pet/domain/entities/medical_entity.dart';

import '../entities/pet_entity.dart';

abstract class PetFirebaseRepository{
  Future<void> addPet(PetEntity petEntity);
  Future<String> addPhoto(File imgUrl);
  Future<String> addCertificate(File ctfUrl);
  Stream<List<MedicalEntity>> getAllMedicalLists();

}