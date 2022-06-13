import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/data/models/pet_model.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class PetDataSource {
  Future<void> addPet(PetEntity adoptEntity);
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl, String oldPhotoUrl);
  Future<String> uploadPetCertificate(
      String petCertificatePath, String oldPath);
  Stream<List<PetEntity>> getPets(String userId);
  Stream<PetEntity> getPetDesc(String petId);
}

class PetDataSourceImpl implements PetDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  PetDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});

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
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("userId");
    return userId ?? '';
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
}
