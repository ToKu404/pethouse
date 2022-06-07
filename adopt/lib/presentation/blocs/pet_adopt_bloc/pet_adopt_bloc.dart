// ignore: unused_import
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:adopt/domain/usecases/get_user_id_local_usecase.dart';
import 'package:path/path.dart';

import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/usecases/get_all_pet_list_usecase.dart';
import 'package:adopt/domain/usecases/create_new_adopt_usecase.dart';
import 'package:adopt/domain/usecases/upload_pet_adopt_photo_usecase.dart';
import 'package:adopt/domain/usecases/upload_pet_certificate_usecase.dart';
import 'package:adopt/domain/usecases/get_pet_description_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pet_adopt_event.dart';
part 'pet_adopt_state.dart';

class PetAdoptBloc extends Bloc<PetAdoptEvent, PetAdoptState> {
  final CreateNewAdoptUsecase createNewAdoptUsecase;
  final UploadPetAdoptPhotoUsecase uploadPetPhoto;
  final UploadPetCertificateUsecase uploadPetCertificateUsecase;

  PetAdoptBloc(
      {required this.createNewAdoptUsecase,
      required this.uploadPetPhoto,
      required this.uploadPetCertificateUsecase
      })
      : super(PetAdoptInitial()) {
    on<SubmitOpenAdopt>((event, emit) async {
      emit(PetAdoptLoading());
      try {
        String petPhotoUrl = "";
        if (event.adoptEntity.petPictureUrl != null &&
            event.adoptEntity.petPictureUrl != '') {
          petPhotoUrl =
              await uploadPetPhoto.execute(event.adoptEntity.petPictureUrl);
        }
        String petCertificateUrl = "";
        if (event.adoptEntity.certificateUrl != null &&
            event.adoptEntity.certificateUrl != '') {
          petCertificateUrl = await uploadPetCertificateUsecase
              .execute(event.adoptEntity.certificateUrl!);
        }
        AdoptEntity adoptEntity = AdoptEntity(
          petName: event.adoptEntity.petName,
          petType: event.adoptEntity.petType,
          gender: event.adoptEntity.gender,
          dateOfBirth: event.adoptEntity.dateOfBirth,
          petDescription: event.adoptEntity.petDescription,
          whatsappNumber: event.adoptEntity.whatsappNumber,
          petBreed: event.adoptEntity.petBreed,
          petPictureUrl: petPhotoUrl,
          certificateUrl: petCertificateUrl,
        );

        await createNewAdoptUsecase.execute(adoptEntity);
        emit(OpenAdoptSuccess());
      } catch (e) {
        emit(PetAdoptError(message: 'error open adopt'));
      }
    });

    on<UploadPetPhoto>(
      (event, emit) async {
        try {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 360,
            imageQuality: 80,
          );
          if (image != null) {
            final path = image.path;
            emit(UploadPetPhotoSuccess(petPhotoPath: path));
          } else {
            emit(PetAdoptError(message: 'failed upload pet photo'));
          }
        } catch (_) {
          emit(PetAdoptError(message: 'failed upload pet photo'));
        }
      },
    );
    on<UploadPetCertificate>(
      (event, emit) async {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'png'],
        );

        if (result != null) {
          if (result.files.first.size < 3000000) {
            String path = result.files.single.path ?? '';
            emit(UploadPetCertificateSuccess(
                petCertificatePath: path,
                petCertificateFileName: basename(path)));
          } else {
            emit(PetAdoptError(message: 'File Terlalu Besar'));
          }
        } else {
          emit(PetAdoptError(message: 'failed upload pet certificate'));
        }
      },
    );
  }
}
