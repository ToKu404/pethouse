

import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/repositories/habbit_repository.dart';

class GetTodayHabbitUsecase {
  final HabbitRepository habbitRepository;

  GetTodayHabbitUsecase(this.habbitRepository);

  Stream<List<HabbitEntity>> execute(String dayName, String petId) {
    return habbitRepository.getTodayHabbit(dayName, petId);
  }
}
