import 'package:petrivia/data/data_sources/petrivia_data_source.dart';
import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:petrivia/domain/repositories/petrivia_repository.dart';

class PetriviaRepositoryImpl implements PetriviaRepository {
  final PetriviaDataSource petriviaDataSource;

  PetriviaRepositoryImpl({required this.petriviaDataSource});

  @override
  Stream<List<PetriviaEntity>> getListPetrivia() {
    return petriviaDataSource.getListPetrivia();
  }
}
