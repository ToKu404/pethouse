import 'package:petrivia/domain/entities/petrivia_entity.dart';

abstract class PetriviaRepository {
  Stream<List<PetriviaEntity>> getListPetrivia();
}
