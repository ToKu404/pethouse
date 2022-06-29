import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/repositories/habbit_repository.dart';

class GetOneReadHabbitUsecase {
  final HabbitRepository habbitRepository;

  GetOneReadHabbitUsecase(this.habbitRepository);

  Future<List<HabbitEntity>> execute(String petId) {
    return habbitRepository.getOneReadHabbits(petId);
  }
}
