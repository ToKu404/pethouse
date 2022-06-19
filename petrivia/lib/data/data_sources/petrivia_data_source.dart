import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petrivia/data/models/petrivia_model.dart';

import '../../domain/entities/petrivia_entity.dart';

abstract class PetriviaDataSource {
  Stream<List<PetriviaEntity>> getListPetrivia();
}

class PetrviaDataSourceImpl implements PetriviaDataSource {
  final FirebaseFirestore firebaseFirestore;

  PetrviaDataSourceImpl({required this.firebaseFirestore});

  @override
  Stream<List<PetriviaEntity>> getListPetrivia() {
    final collectionRef = firebaseFirestore.collection('petrivia');
    return collectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map(
            (e) => PetriviaModel.fromSnapshot(e),
          )
          .toList();
    });
  }
}
