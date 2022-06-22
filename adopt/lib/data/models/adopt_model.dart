import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/adopt_enitity.dart';

class AdoptModel extends AdoptEntity {
  const AdoptModel({
    final String? adoptId,
    final String? userId,
    final String? petName,
    final String? petType,
    final String? petTypeText,
    final String? petPictureUrl,
    final String? gender,
    final String? petBreed,
    final Timestamp? dateOfBirth,
    final String? certificateUrl,
    final String? whatsappNumber,
    final String? petDecription,
    final String? status,
    final String? adopterId,
    final String? adopterName,
    final List<String>? titleSearch,
  }) : super(
            adoptId: adoptId,
            userId: userId,
            petName: petName,
            petType: petType,
            petPictureUrl: petPictureUrl,
            gender: gender,
            petTypeText: petTypeText,
            petBreed: petBreed,
            dateOfBirth: dateOfBirth,
            certificateUrl: certificateUrl,
            whatsappNumber: whatsappNumber,
            petDescription: petDecription,
            status: status,
            adopterId: adopterId,
            adopterName: adopterName,
            titleSearch: titleSearch);

  Map<String, dynamic> toDocument() {
    return {
      "adopt_id": adoptId,
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
      "whatsapp_number": whatsappNumber,
      "status": status,
      "adopter_id": adopterId,
      "adopter_name": adopterName,
      "title_search": titleSearch,
    };
  }

  factory AdoptModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return AdoptModel(
      adoptId: documentSnapshot.get("adopt_id"),
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
      whatsappNumber: documentSnapshot.get("whatsapp_number"),
      status: documentSnapshot.get('status'),
      adopterId: documentSnapshot.get('adopter_id'),
      adopterName: documentSnapshot.get('adopter_name'),
      titleSearch:
          List<String>.from(documentSnapshot["title_search"].map((x) => x)),
    );
  }

  @override
  List<Object?> get props => [
        adoptId,
        userId,
        petName,
        petType,
        petPictureUrl,
        gender,
        petTypeText,
        petBreed,
        dateOfBirth,
        certificateUrl,
        whatsappNumber,
        petDescription,
        status,
        adopterId,
        adopterName,
        titleSearch
      ];
}
