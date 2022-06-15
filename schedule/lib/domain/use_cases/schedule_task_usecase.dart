import 'package:schedule/domain/repositories/schedule_repository.dart';

class ScheduleTaskUsecase {
  final ScheduleRepository scheduleRepository;

  ScheduleTaskUsecase(this.scheduleRepository);

  Future<bool> execute(bool value, String date) {
    return scheduleRepository.scheduleTask(value, date);
  }
}
