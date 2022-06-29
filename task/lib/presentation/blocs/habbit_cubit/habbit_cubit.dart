import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/use_cases/insert_habbit_usecase.dart';
import 'package:task/domain/use_cases/remove_habbit_usecase.dart';
part 'habbit_state.dart';

class HabbitCubit extends Cubit<HabbitState> {
  final InsertHabbitUsecase insertHabbitUsecase;
  final RemoveHabbitUsecase removeHabbitUsecase;
  HabbitCubit({
    required this.insertHabbitUsecase,
    required this.removeHabbitUsecase,
  }) : super(HabbitInitial());

  Future<void> onAddHabbit(HabbitEntity habbitEntity) async {
    emit(HabbitLoading());
    try {
      await insertHabbitUsecase.execute(habbitEntity);
      emit(AddHabbitSuccess());
    } catch (_) {
      emit(const AddHabbitFailure(message: 'Error'));
    }
  }

  Future<void> onRemoveHabbit(HabbitEntity habbitEntity) async {
    emit(HabbitLoading());
    try {
      await removeHabbitUsecase.execute(habbitEntity.id!);
      emit(RemoveHabbitSuccess());
    } catch (_) {
      emit(const RemoveHabbitFailure(message: 'Error'));
    }
  }
}
