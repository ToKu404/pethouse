import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pet/domain/usecases/add_pet_usecase.dart';
import 'package:pet/domain/usecases/add_photo_usecase.dart';

import '../../../domain/entities/pet_entity.dart';
import '../../../domain/usecases/add_certificate_usecase.dart';

part 'add_pet_event.dart';
part 'add_pet_state.dart';

class AddPetBloc extends Bloc<AddPetEvent, AddPetState> {
  final AddPetUseCase addPetUsecase;
  final AddPhotoUseCase addPhotoUsecase;
  final AddCertificateUseCase addCertificateUsecase;

  AddPetBloc({required this.addPetUsecase, required this.addPhotoUsecase, required this.addCertificateUsecase})
      : super(AddPetInitial()) {
    on<CreatePet>((event, emit) async {
      // TODO: implement event handler
      emit(AddPetLoading());
      await addPetUsecase.execute(event.petEntity);
      emit(AddPetSucces());
    });
    on<SetPhoto>((event, emit) async {
      // TODO: implement event handler

      final ImagePicker imgUrl = ImagePicker();
      final XFile? imgFile =
          await imgUrl.pickImage(source: ImageSource.gallery);
      String result = '';

      if (imgFile != null) {
        File imgPicker = File(imgFile.path);
        result = await addPhotoUsecase.execute(imgPicker);
      }

      emit(UpPhotoSucces(result));
    });
    on<SetCertificate>((event, emit) async {
      // TODO: implement event handler

      final ImagePicker ctfUrl = ImagePicker();
      final XFile? ctfFile =
          await ctfUrl.pickImage(source: ImageSource.gallery);
      String result = '';

      if (ctfFile != null) {
        File ctfPicker = File(ctfFile.path);
        result = await addPhotoUsecase.execute(ctfPicker);
      }

      emit(UpCertificateSucces(result));
    });
  }
}
