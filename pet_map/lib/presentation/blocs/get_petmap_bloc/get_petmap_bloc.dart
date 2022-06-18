import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_map/domain/entities/pet_map_entity.dart';
import 'package:pet_map/domain/usecases/get_petmap_usecase.dart';

part 'get_petmap_event.dart';
part 'get_petmap_state.dart';

class GetPetMapBloc extends Bloc<GetPetMapEvent, GetPetMapState> {
  final GetPetMapUsecase getPetMapUsecase;
  GetPetMapBloc({required this.getPetMapUsecase}) : super(GetPetMapInitial()) {
    on<GetPetMap>((event, emit) {
      emit(GetPetMapSuccess(petMapEntity: event.petMap));
    });
    on<FetchPetMap>(
      (event, emit) async {
        emit(GetPetMapLoading());
        try {
          getPetMapUsecase.execute(event.id).listen((petMap) {
            add(GetPetMap(petMap: petMap));
          });
        } catch (_) {
          emit(GetPetMapError(message: "error load data"));
        }
      },
    );
  }
}
