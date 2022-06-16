import 'package:equatable/equatable.dart';

class PetriviaEntity extends Equatable {
  final String? id;
  final String? title;
  final String? value;
  final String? source;
  final String? imgUrl;
  final List<String>? tags;

  const PetriviaEntity(
      {this.id,
      required this.title,
      required this.value,
      this.source,
      required this.imgUrl,
      required this.tags});

  @override
  List<Object?> get props => [id, title, value, source, tags, imgUrl];
}
