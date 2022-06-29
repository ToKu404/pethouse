// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:core/services/preference_helper.dart';
import 'package:path/path.dart';
import 'package:adopt/data/models/adopt_model.dart';
import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class AdoptDataSource {
  Future<void> createNewAdopt(AdoptEntity adoptEntity);
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl, String oldPhotoUrl);
  Future<String> uploadPetCertificate(
      String petCertificatePath, String oldPath);
  Stream<List<AdoptEntity>> getAllPetLists();
  Stream<AdoptEntity> getPetDescription(String petId);
  Future<String> getUserIdLocal();
  Future<void> updateAdopt(AdoptEntity adoptEntity);
  Stream<List<AdoptEntity>> getOpenAdoptList(String userId);
  Stream<List<AdoptEntity>> getRequestAdoptList(String userId);
  Future<void> requestAdopt(AdoptEntity adoptd);
  Future<void> removeOpenAdopt(String adoptId);
  Stream<List<AdoptEntity>> searchPetAdopt(String query);
}

class AdoptDataSourceImpl implements AdoptDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final PreferenceHelper preferenceHelper;

  AdoptDataSourceImpl(
      {required this.firebaseFirestore,
      required this.firebaseStorage,
      required this.preferenceHelper});

  // Create new adopt data on firestore
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
        petTypeText: adoptEntity.petTypeText,
        dateOfBirth: adoptEntity.dateOfBirth,
        petPictureUrl: adoptEntity.petPictureUrl,
        certificateUrl: adoptEntity.certificateUrl,
        petDecription: adoptEntity.petDescription,
        whatsappNumber: adoptEntity.whatsappNumber,
        status: adoptEntity.status,
        adopterId: adoptEntity.adopterId,
        adopterName: adoptEntity.adopterName,
        titleSearch: adoptEntity.titleSearch,
      ).toDocument();
      //check if value is not exist then set new value
      if (!value.exists) {
        adoptCollectionRef.doc(adoptId).set(newAdopt);
      }
      return;
    });
  }

  // Upload image to firebase storage then get download url
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

  //get user id
  @override
  Future<String> getUserIdLocal() async {
    return await preferenceHelper.getUserId();
  }

  // upload certificate file to firebase storage then get download url
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
      //generate unique file name for certificate name
      const uuid = Uuid();
      final ext = filename.split('.');
      filename = uuid.v1() + ext[1];
      final ref =
          firebaseStorage.ref().child('pet_certificates').child(filename);
      await ref.putFile(File(petCertificatePath));
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}': ${e.message}";
    }
  }

  //get all pet adopt data from firestore when status is open
  @override
  Stream<List<AdoptEntity>> getAllPetLists() {
    final petCollectionRef = firebaseFirestore
        .collection("pet_adopts")
        .where('status', isEqualTo: 'open');
    return petCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => AdoptModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  //get user open adopt data
  @override
  Stream<List<AdoptEntity>> getOpenAdoptList(String userId) {
    final petCollectionRef = firebaseFirestore
        .collection("pet_adopts")
        .where('user_id', isEqualTo: userId);
    return petCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => AdoptModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  //get user open adopt data
  @override
  Stream<List<AdoptEntity>> getRequestAdoptList(String adopterId) {
    final petCollectionRef = firebaseFirestore
        .collection("pet_adopts")
        .where('adopter_id', isEqualTo: adopterId);
    return petCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => AdoptModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  //get pet adopt description
  @override
  Stream<AdoptEntity> getPetDescription(String petId) {
    final petCollectionRef =
        firebaseFirestore.collection('pet_adopts').doc(petId).snapshots();
    return petCollectionRef.map((querySnap) {
      return AdoptModel.fromSnapshot(querySnap);
    });
  }

  //update adopt data
  @override
  Future<void> updateAdopt(AdoptEntity adoptEntity) async {
    //check adopt data has been change
    Map<String, dynamic> adoptMap = {};
    onUpdate('pet_picture_url', adoptEntity.petPictureUrl, adoptMap);
    onUpdate('pet_name', adoptEntity.petName, adoptMap);
    onUpdate('pet_type', adoptEntity.petType, adoptMap);
    onUpdate('pet_type_text', adoptEntity.petTypeText, adoptMap);
    onUpdate('gender', adoptEntity.gender, adoptMap);
    onUpdate('pet_breed', adoptEntity.petBreed, adoptMap);
    onUpdate('date_of_birth', adoptEntity.dateOfBirth, adoptMap);
    onUpdate('certificate_url', adoptEntity.certificateUrl, adoptMap);
    onUpdate('pet_decription', adoptEntity.petDescription, adoptMap);
    onUpdate('whatsapp_number', adoptEntity.whatsappNumber, adoptMap);
    if (adoptEntity.petName != null && adoptEntity.petName != '') {
      adoptMap['title_search'] = adoptEntity.titleSearch;
    }

    await firebaseFirestore
        .collection('pet_adopts')
        .doc(adoptEntity.adoptId)
        .update(adoptMap);
  }

  void onUpdate(String key, dynamic value, Map<String, dynamic> adoptMap) {
    if (value != null && value != '') {
      adoptMap[key] = value;
    }
  }

  // send request adopt from adopter to pet owner
  @override
  Future<void> requestAdopt(AdoptEntity adopt) async {
    Map<String, dynamic> adoptMap = {};
    adoptMap['status'] = adopt.status;
    adoptMap['adopter_id'] = adopt.adopterId;
    adoptMap['adopter_name'] = adopt.adopterName;
    await firebaseFirestore.collection('pet_adopts').doc(adopt.adoptId).update(
        adoptMap); // await firebaseFirestore.collection('notifications').doc(adopt.userId)
  }

  // remove open adopt data from firestore
  @override
  Future<void> removeOpenAdopt(String adoptId) async {
    await firebaseFirestore.collection('pet_adopts').doc(adoptId).delete();
  }

  //seatch pet adopt
  @override
  Stream<List<AdoptEntity>> searchPetAdopt(String query) {
    final collectionReference = firebaseFirestore
        .collection('pet_adopts')
        .where('title_search', arrayContains: query);
    return collectionReference.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => AdoptModel.fromSnapshot(docSnap))
          .toList();
    });
  }
}
