
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_map/domain/usecases/get_all_petmap_usecase.dart';

import '../../../domain/entities/pet_map_entity.dart';

part 'get_all_petmap_event.dart';
part 'get_all_petmap_state.dart';

class GetAllPetMapBloc extends Bloc<GetAllPetMapEvent, GetAllPetMapState> {
  final GetAllPetMapUsecase getAllPetMapUsecase;

  GetAllPetMapBloc({required this.getAllPetMapUsecase}) : super(GetAllPetMapInitial()) {
    on<GetPetMaps>((event, emit) {
    
      emit(GetAllPetMapSuccess(petMap: event.petMaps));
    });
    on<FetchAllPetMap>(
      (event, emit) async {
        emit(GetAllPetMapLoading());
        // final result = await getAllPetListUsecase.e
        try {
          getAllPetMapUsecase.execute().listen((petMap) {
            add(GetPetMaps(petMaps: petMap));
          });
        } catch (_) {
          emit(GetAllPetMapError(message: "error load data"));
        }
      },
    );
  }
}
