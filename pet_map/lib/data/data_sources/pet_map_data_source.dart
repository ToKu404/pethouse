import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_map/data/models/pet_map_model.dart';

import '../../domain/entities/pet_map_entity.dart';

abstract class PetMapDataSource {
  Future<void> createPetMap(PetMapEntity petMapEntity);
  Future<void> removePetMap(String petMapId);
  Stream<List<PetMapEntity>> getAllPetMap();
  Future<bool> checkPetMap(String petMapId);
  Stream<PetMapEntity> getPetMap(String userId);
  Future<void> updatePetMap(PetMapEntity petMapEntity);
}

class PetMapDataSourceImpl implements PetMapDataSource {
  final FirebaseFirestore firebaseFirestore;

  PetMapDataSourceImpl(this.firebaseFirestore);

  @override
  Future<void> createPetMap(PetMapEntity petMap) async {
    final collectionRef = firebaseFirestore.collection('pet_maps');
    collectionRef.doc(petMap.id).get().then((value) {
      final newPetMap = PetMapModel(
              id: petMap.id,
              latitude: petMap.latitude,
              longitude: petMap.longitude,
              petPhotoUrl: petMap.petPhotoUrl,
              name: petMap.name)
          .toDocument();
      if (!value.exists) {
        collectionRef.doc(petMap.id).set(newPetMap);
      }
    });
  }

  @override
  Stream<List<PetMapEntity>> getAllPetMap() {
    final collectionRef = firebaseFirestore.collection('pet_maps');
    return collectionRef.snapshots().map((qs) {
      return qs.docs.map((e) => PetMapModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Future<void> removePetMap(String petMapId) async {
    await firebaseFirestore.collection('pet_maps').doc(petMapId).delete();
  }

  @override
  Future<bool> checkPetMap(String petMapId) async {
    final collectionRef = firebaseFirestore.collection('pet_maps');
    return collectionRef
        .doc(petMapId)
        .get()
        .then((value) => value.exists ? true : false);
  }

  @override
  Stream<PetMapEntity> getPetMap(String userId) {
    final collectionRef =
        firebaseFirestore.collection('pet_maps').doc(userId).snapshots();

    return collectionRef.map((querySnap) {
      return PetMapModel.fromSnapshot(querySnap);
    });
  }

  @override
  Future<void> updatePetMap(PetMapEntity petMapEntity) async {
    Map<String, dynamic> petMap = {};
    onUpdate('latitude', petMapEntity.latitude, petMap);
    onUpdate('longitude', petMapEntity.longitude, petMap);

    await firebaseFirestore
        .collection('pet_maps')
        .doc(petMapEntity.id)
        .update(petMap);
  }

  void onUpdate(String key, dynamic value, Map<String, dynamic> adoptMap) {
    if (value != null && value != '') {
      adoptMap[key] = value;
    }
  }
}
