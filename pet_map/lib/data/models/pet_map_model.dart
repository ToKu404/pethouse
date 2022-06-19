import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_map/domain/entities/pet_map_entity.dart';

class PetMapModel extends PetMapEntity {
  PetMapModel(
      {final String? id,
      final String? petPhotoUrl,
      final double? latitude,
      final String? name,
      final double? longitude})
      : super(
            id: id,
            petPhotoUrl: petPhotoUrl,
            latitude: latitude,
            longitude: longitude,
            name: name,
            );

  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "pet_photo_url": petPhotoUrl,
      "latitude": latitude,
      "longitude": longitude,
      "name" : name
      ,
    };
  }

  factory PetMapModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PetMapModel(
      id: documentSnapshot.get('id'),
      petPhotoUrl: documentSnapshot.get('pet_photo_url'),
      latitude: documentSnapshot.get('latitude'),
      longitude: documentSnapshot.get('longitude'),
      name: documentSnapshot.get('name') ,

    );
  }
}
