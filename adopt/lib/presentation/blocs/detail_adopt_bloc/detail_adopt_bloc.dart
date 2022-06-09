import 'dart:convert';

import 'package:adopt/domain/usecases/request_adopt_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/get_pet_description_usecase.dart';
import '../../../domain/usecases/get_user_id_local_usecase.dart';

part 'detail_adopt_event.dart';
part 'detail_adopt_state.dart';

class DetailAdoptBloc extends Bloc<DetailAdoptEvent, DetailAdoptState> {
  final GetUserIdLocalUsecase getUserIdLocalUsecase;
  final GetPetDescriptionUsecase getPetDescriptionUsecase;
  final RequestAdoptUsecase requestAdoptUsecase;

  DetailAdoptBloc(
      {required this.getUserIdLocalUsecase,
      required this.getPetDescriptionUsecase,
      required this.requestAdoptUsecase})
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
    on<RequestAdopt>(
      (event, emit) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? user = prefs.getString('userData');
        Map<String, dynamic> userMap = json.decode(user!);

        AdoptEntity adopt = AdoptEntity(
            petName: '',
            petType: '',
            gender: '',
            adoptId: event.adoptEntity.adoptId,
            status: 'wait',
            adopterId: userMap['uid'],
            adopterName: userMap['name'],
            userId: event.adoptEntity.userId);
        await requestAdoptUsecase.execute(adopt);
        emit(SuccessRequestAdopt());
      },
    );
  }
}
