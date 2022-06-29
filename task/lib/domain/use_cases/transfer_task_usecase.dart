import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';
import 'package:task/domain/repositories/task_repository.dart';

class TransferTaskUsecase {
  final TaskFirebaseRepository taskFirebaseRepository;

  TransferTaskUsecase(this.taskFirebaseRepository);

  Future<void> execute(
      List<HabbitEntity> habbits, List<TaskEntity> tasks) {
    return taskFirebaseRepository.transferTask(habbits, tasks);
  }
}
