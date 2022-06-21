import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/repositories/task_repository.dart';

class TransferTaskUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  TransferTaskUsecase(this.taskFirebaseRepository);

  Future<void> execute(
      List<HabbitEntity> habbits, DateTime date, String petId) {
    return taskFirebaseRepository.transferTask(habbits, date, petId);
  }
}
