import '../entities/habbit_entity.dart';

abstract class HabbitRepository {
  Future<void> insertHabbit(HabbitEntity habbitEntity);
  Future<List<HabbitEntity>> getOneReadHabbits(String petId);
  Stream<List<HabbitEntity>> getTodayHabbit(String dayName, String petId);
  Stream<List<HabbitEntity>> getAllHabbits(String petId);
  Future<void> removeHabbit(String habbitId);
}
