import 'dart:io';

import 'package:pet/data/data_sources/pet_firebase_data_source.dart';

import '../../domain/entities/pet_entity.dart';
import '../../domain/repositories/pet_firebase_repository.dart';

class PetFirebaseRepositoryImpl implements PetFirebaseRepository{
  final PetFirebaseDataSource petFirebaseDataSource;

  PetFirebaseRepositoryImpl({required this.petFirebaseDataSource});

  @override
  Future<void> addPet(PetEntity petEntity) async{

    petFirebaseDataSource.addPet(petEntity);
  }

  @override
  Future<String> addPhoto(File imgUrl) {
    // TODO: implement addPhoto
    throw UnimplementedError();
  }

}