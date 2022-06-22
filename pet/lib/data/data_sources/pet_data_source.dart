import 'dart:io';
import 'package:core/services/preference_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/data/models/pet_model.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:uuid/uuid.dart';

abstract class PetDataSource {
  Future<void> addPet(PetEntity adoptEntity);
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl, String oldPhotoUrl);
  Future<String> uploadPetCertificate(
      String petCertificatePath, String oldPath);
  Stream<List<PetEntity>> getPets(String userId);
  Stream<PetEntity> getPetDesc(String petId);
  Future<void> updatePetData(PetEntity petEntity);
  Future<void> removePetData(String petId);
}

class PetDataSourceImpl implements PetDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final PreferenceHelper preferenceHelper;

  PetDataSourceImpl(
      {required this.firebaseFirestore,
      required this.firebaseStorage,
      required this.preferenceHelper});

  @override
  Future<void> addPet(PetEntity petEntity) async {
    final adoptCollectionRef = firebaseFirestore.collection("pets");
    final id = adoptCollectionRef.doc().id;
    final userId = await getUserIdLocal();
    adoptCollectionRef.doc(id).get().then((value) {
      final newAdopt = PetModel(
        id: id,
        userId: userId,
        petName: petEntity.petName,
        petType: petEntity.petType,
        gender: petEntity.gender,
        petBreed: petEntity.petBreed,
        dateOfBirth: petEntity.dateOfBirth,
        petTypeText: petEntity.petTypeText,
        petPictureUrl: petEntity.petPictureUrl,
        certificateUrl: petEntity.certificateUrl,
        petDecription: petEntity.petDescription,
      ).toDocument();
      if (!value.exists) {
        adoptCollectionRef.doc(id).set(newAdopt);
      }
      return;
    });
  }

  @override
  Future<String> uploadPetAdoptPhoto(
      String? petPhotoUrl, String oldPhotoUrl) async {
    if (petPhotoUrl != null) {
      String filename = basename(petPhotoUrl);
      if (oldPhotoUrl != '') {
        await firebaseStorage
            .ref()
            .child('pet_photos')
            .child(oldPhotoUrl)
            .delete();
      }
      final ref = firebaseStorage.ref().child('pet_photos').child(filename);
      await ref.putFile(File(petPhotoUrl));
      return await ref.getDownloadURL();
    } else {
      return "";
    }
  }

  Future<String> getUserIdLocal() async {
    return await preferenceHelper.getUserId();
  }

  @override
  Future<String> uploadPetCertificate(
      String petCertificatePath, String oldPath) async {
    try {
      if (oldPath != '') {
        final certRef =
            firebaseStorage.ref().child("pet_certificates/$oldPath");
        await certRef.delete();
      }
      String filename = basename(petCertificatePath);
      const uuid = Uuid();
      final ext = filename.split('.');
      filename = "${uuid.v1()}.${ext[1]}";

      final ref =
          firebaseStorage.ref().child('pet_certificates').child(filename);
      await ref.putFile(File(petCertificatePath));
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}': ${e.message}";
    }
  }

  @override
  Stream<List<PetEntity>> getPets(String userId) {
    final petCollection = firebaseFirestore
        .collection('pets')
        .where('user_id', isEqualTo: userId);
    return petCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => PetModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<PetEntity> getPetDesc(String petId) {
    final petCollection = firebaseFirestore.collection('pets').doc(petId);
    return petCollection
        .snapshots()
        .map((event) => PetModel.fromSnapshot(event));
  }

  @override
  Future<void> removePetData(String petId) async {
    await firebaseFirestore.collection('pets').doc(petId).delete();
  }

  @override
  Future<void> updatePetData(PetEntity petEntity) async {
    Map<String, dynamic> petMap = {};
    onUpdate('pet_name', petEntity.petName, petMap);
    onUpdate('pet_type', petEntity.petType, petMap);
    onUpdate('pet_picture_url', petEntity.petPictureUrl, petMap);
    onUpdate('gender', petEntity.gender, petMap);
    onUpdate('pet_breed', petEntity.petBreed, petMap);
    onUpdate('pet_type_text', petEntity.petTypeText, petMap);
    onUpdate('date_of_birth', petEntity.dateOfBirth, petMap);
    onUpdate('certificate_url', petEntity.certificateUrl, petMap);
    onUpdate('pet_description', petEntity.petDescription, petMap);

    await firebaseFirestore.collection('pets').doc(petEntity.id).update(petMap);
  }

  void onUpdate(String key, dynamic value, Map<String, dynamic> petMap) {
    if (value != null && value != '') {
      petMap[key] = value;
    }
  }
}
