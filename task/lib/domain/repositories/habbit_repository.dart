import '../entities/habbit_entity.dart';

abstract class HabbitRepository {
  Future<void> insertHabbit(HabbitEntity habbitEntity);
  Stream<List<HabbitEntity>> getTodayHabbit(String dayName, String petId);
  Stream<List<HabbitEntity>> getAllHabbits(String petId);
  Future<void> removeHabbit(String habbitId);
}
