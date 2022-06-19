import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetriviaModel extends PetriviaEntity {
  const PetriviaModel({
    final String? id,
    final String? title,
    final String? value,
    final String? source,
    final List<String>? tags,
    final String? imgUrl,
  }) : super(
            id: id,
            title: title,
            value: value,
            source: source,
            tags: tags,
            imgUrl: imgUrl);

  factory PetriviaModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PetriviaModel(
      id: documentSnapshot.get('id'),
      title: documentSnapshot.get('title'),
      value: documentSnapshot.get('value'),
      source: documentSnapshot.get('source'),
      imgUrl: documentSnapshot.get('img_url'),
      tags: List<String>.from(documentSnapshot["tags"].map((x) => x)),
    );
  }
}
