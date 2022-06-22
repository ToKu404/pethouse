

import '../repositories/habbit_repository.dart';

class RemoveHabbitUsecase {
  final HabbitRepository habbitRepository;

  RemoveHabbitUsecase(this.habbitRepository);

  Future<void> execute(String habbitId) {
    return habbitRepository.removeHabbit(habbitId);
  }
}
