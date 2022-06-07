import 'dart:io';

import 'package:adopt/data/models/adopt_model.dart';
import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AdoptDataSource {
  Future<void> createNewAdopt(AdoptEntity adoptEntity);
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl);
  Future<String> uploadPetCertificate(String petCertificatePath);
  Stream<List<AdoptEntity>> getAllPetLists();
  Stream<AdoptEntity> getPetDescription(String petId);
  Future<String> getUserIdLocal();
}

class AdoptDataSourceImpl implements AdoptDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  AdoptDataSourceImpl(
      {required this.firebaseFirestore,
      required this.firebaseStorage,
      required this.firebaseAuth});

  @override
  Future<void> createNewAdopt(AdoptEntity adoptEntity) async {
    final adoptCollectionRef = firebaseFirestore.collection("pet_adopts");
    final adoptId = adoptCollectionRef.doc().id;
    final userId = await getUserIdLocal();
    adoptCollectionRef.doc(adoptEntity.adoptId).get().then((value) {
      final newAdopt = AdoptModel(
              adoptId: adoptId,
              userId: userId,
              petName: adoptEntity.petName,
              petType: adoptEntity.petType,
              gender: adoptEntity.gender,
              petBreed: adoptEntity.petBreed,
              dateOfBirth: adoptEntity.dateOfBirth,
              petPictureUrl: adoptEntity.petPictureUrl,
              certificateUrl: adoptEntity.certificateUrl,
              petDecription: adoptEntity.petDescription,
              whatsappNumber: adoptEntity.whatsappNumber)
          .toDocument();
      if (!value.exists) {
        adoptCollectionRef.doc(adoptId).set(newAdopt);
      }
      return;
    });
  }

  @override
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl) async {
    if (petPhotoUrl != null) {
      String filename = basename(petPhotoUrl);
      final ref = firebaseStorage.ref().child('pet_photos').child(filename);
      await ref.putFile(File(petPhotoUrl));
      return await ref.getDownloadURL();
    } else {
      return "";
    }
  }

  @override
  Future<String> getUserIdLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("userId");
    return userId ?? '';
  }

  @override
  Future<String> uploadPetCertificate(String petCertificatePath) async {
    try {
      String filename = basename(petCertificatePath);
      final ref =
          firebaseStorage.ref().child('pet_certificates').child(filename);
      await ref.putFile(File(petCertificatePath));
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}': ${e.message}";
    }
  }

  @override
  Stream<List<AdoptEntity>> getAllPetLists() {
    final petCollectionRef = firebaseFirestore.collection("pet_adopts");
    return petCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => AdoptModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<AdoptEntity> getPetDescription(String petId) {
    final petCollectionRef =
        firebaseFirestore.collection('pet_adopts').doc(petId).snapshots();
    return petCollectionRef.map((querySnap) {
      return AdoptModel.fromSnapshot(querySnap);
    });
  }
}
