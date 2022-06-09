import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? imgUrl,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          imageUrl: imgUrl,
        );

  Map<String, dynamic> toDocument() {
    return {"img_url": imageUrl, "uid": uid, "email": email, "name": name};
  }

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      imgUrl: documentSnapshot.get('img_url'),
      name: documentSnapshot.get('name'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
    );
  }

  Map<String, dynamic> toJson() {
    return {"imgUrl": imageUrl, "uid": uid, "email": email, "name": name};
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        imgUrl: parsedJson['imgUrl'] ?? '',
        name: parsedJson['name'] ?? '',
        uid: parsedJson['uid'] ?? '',
        email: parsedJson['email'] ?? '');
  }

  @override
  List<Object?> get props => [name, email, imageUrl, uid];
}
