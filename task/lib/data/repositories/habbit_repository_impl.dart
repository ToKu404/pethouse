

import 'package:task/data/data_sources/habbit_data_sources.dart';
import 'package:task/domain/entities/habbit_entity.dart';

import '../../domain/repositories/habbit_repository.dart';

class HabbitRepositoryImpl implements HabbitRepository {
  final HabbitDataSource habbitDataSource;

  HabbitRepositoryImpl(this.habbitDataSource);

  @override
  Future<void> insertHabbit(HabbitEntity habbitEntity) {
    return habbitDataSource.insertHabbit(habbitEntity);
  }

  @override
  Future<void> removeHabbit(String habbitId) {
    return habbitDataSource.removeHabbit(habbitId);
  }

  @override
  Stream<List<HabbitEntity>> getTodayHabbit(String dayName, String petId) {
    return habbitDataSource.getTodayHabbit(dayName, petId);
  }

  @override
  Stream<List<HabbitEntity>> getAllHabbits(String petId) {
    return habbitDataSource.getAllHabbits(petId);
  }
}
