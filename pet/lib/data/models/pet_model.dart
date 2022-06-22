import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/domain/entities/pet_entity.dart';

class PetModel extends PetEntity {
  const PetModel({
    final String? id,
    final String? userId,
    final String? petName,
    final String? petType,
    final String? petPictureUrl,
    final String? gender,
    final String? petTypeText,
    final String? petBreed,
    final Timestamp? dateOfBirth,
    final String? certificateUrl,
    final String? petDecription,
  }) : super(
          id: id,
          userId: userId,
          petName: petName,
          petType: petType,
          petPictureUrl: petPictureUrl,
          gender: gender,
          petTypeText: petTypeText,
          petBreed: petBreed,
          dateOfBirth: dateOfBirth,
          certificateUrl: certificateUrl,
          petDescription: petDecription,
        );

  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "user_id": userId,
      "pet_name": petName,
      "pet_type": petType,
      "pet_type_text": petTypeText,
      "pet_picture_url": petPictureUrl,
      "gender": gender,
      "pet_breed": petBreed,
      "date_of_birth": dateOfBirth,
      "certificate_url": certificateUrl,
      "pet_decription": petDescription,
    };
  }

  factory PetModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PetModel(
      id: documentSnapshot.get("id"),
      userId: documentSnapshot.get("user_id"),
      petName: documentSnapshot.get("pet_name"),
      petType: documentSnapshot.get("pet_type"),
      petTypeText: documentSnapshot.get("pet_type_text"),
      petPictureUrl: documentSnapshot.get("pet_picture_url"),
      gender: documentSnapshot.get("gender"),
      petBreed: documentSnapshot.get("pet_breed"),
      dateOfBirth: documentSnapshot.get("date_of_birth"),
      certificateUrl: documentSnapshot.get("certificate_url"),
      petDecription: documentSnapshot.get("pet_decription"),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        petName,
        petType,
        petPictureUrl,
        gender,
        petTypeText,
        petBreed,
        dateOfBirth,
        certificateUrl,
        petDescription,
      ];
}
