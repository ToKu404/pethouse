import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/get_pet_description_usecase.dart';
import '../../../domain/usecases/get_user_id_local_usecase.dart';

part 'detail_adopt_event.dart';
part 'detail_adopt_state.dart';

class DetailAdoptBloc extends Bloc<DetailAdoptEvent, DetailAdoptState> {
  final GetUserIdLocalUsecase getUserIdLocalUsecase;
  final GetPetDescriptionUsecase getPetDescriptionUsecase;

  DetailAdoptBloc(
      {required this.getUserIdLocalUsecase,
      required this.getPetDescriptionUsecase})
      : super(DetailAdoptInitial()) {
    on<GetPetDescription>(
      (event, emit) async {
        final userId = await getUserIdLocalUsecase.execute();
        bool isOwner = false;
        if (userId.toString() == event.adoptEntity.userId) {
          isOwner = true;
        }
        emit(PetDescriptionLoaded(
            adoptEntity: event.adoptEntity, isOwner: isOwner));
      },
    );
    on<FetchPetDescription>(
      (event, emit) {
        emit(DetailAdoptLoading());
        try {
          getPetDescriptionUsecase.execute(event.petId).listen((event) {
            add(GetPetDescription(adoptEntity: event));
          });
        } catch (_) {
          emit(DetailAdoptError(message: "error load data"));
        }
      },
    );
  }
}
