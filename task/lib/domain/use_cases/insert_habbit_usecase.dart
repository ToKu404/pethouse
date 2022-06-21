

import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/repositories/habbit_repository.dart';

class InsertHabbitUsecase {
  final HabbitRepository habbitRepository;

  InsertHabbitUsecase(this.habbitRepository);

  Future<void> execute(HabbitEntity habbitEntity) {
    return habbitRepository.insertHabbit(habbitEntity);
  }
}
