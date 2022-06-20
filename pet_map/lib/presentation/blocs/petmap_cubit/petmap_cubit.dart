import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_map/domain/entities/pet_map_entity.dart';
import 'package:pet_map/domain/usecases/create_petmap_usecase.dart';
import 'package:pet_map/domain/usecases/remove_petmap_usecase.dart';
import 'package:pet_map/domain/usecases/update_petmap_usecase.dart';

import '../../../domain/usecases/check_petmap_usecase.dart';

part 'petmap_state.dart';

class PetmapCubit extends Cubit<PetmapState> {
  final RemovePetMapUsecase removePetMapUsecase;
  final CreatePetMapUsecase createPetMapUsecase;
  final CheckPetMapUsecase checkPetMapUsecase;
  final UpdatePetMapUsecase updatePetMapUsecase;

  PetmapCubit({
    required this.removePetMapUsecase,
    required this.createPetMapUsecase,
    required this.checkPetMapUsecase,
    required this.updatePetMapUsecase,
  }) : super(PetmapInitial());

  Future<void> onCreatePetMap(PetMapEntity petMapEntity) async {
    try {
      await createPetMapUsecase.execute(petMapEntity);
      emit(PetmapCreateSuccess());
      emit(CheckPetMapExists());
    } catch (_) {
      emit(PetmapCreateFailure());
    }
  }

  Future<void> onRemovePetMap(String petMapId) async {
    try {
      await removePetMapUsecase.execute(petMapId);
      emit(PetmapRemoveSuccess());
      emit(CheckPetMapEmpty());
    } catch (_) {
      emit(PetmapRemoveFailure());
    }
  }

  Future<void> checkPetMapStatus(String id) async {
    final result = await checkPetMapUsecase.execute(id);
    if (result) {
      emit(CheckPetMapExists());
    } else {
      emit(CheckPetMapEmpty());
    }
  }

  Future<void> updatePetMap(PetMapEntity petMapEntity) async {
    try {
      await updatePetMapUsecase.execute(petMapEntity);
      emit(UpdatePetMapSuccess());
      emit(CheckPetMapExists());
    } catch (_) {
      emit(UpdatePetMapError());
    }
  }
}
