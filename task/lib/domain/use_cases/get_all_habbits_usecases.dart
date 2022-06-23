

import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/repositories/habbit_repository.dart';

class GetAllHabbitsUsecase {
  final HabbitRepository habbitRepository;

  GetAllHabbitsUsecase(this.habbitRepository);

  Stream<List<HabbitEntity>> execute(String petId) {
    return habbitRepository.getAllHabbits(petId);
  }
}
