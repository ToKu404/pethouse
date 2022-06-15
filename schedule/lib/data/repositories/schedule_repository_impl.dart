import 'package:schedule/data/data_sources/schedule_data_source.dart';
import 'package:schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDataSource scheduleDataSource;

  ScheduleRepositoryImpl({required this.scheduleDataSource});

  @override
  Future<bool> scheduleTask(bool value, String time) {
    return scheduleDataSource.scheduleTask(value, time);
  }
}
