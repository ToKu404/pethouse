// ignore: depend_on_referenced_packages
import 'package:core/core.dart';
import 'package:path/path.dart';
import 'package:adopt/domain/usecases/update_adopt_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/upload_pet_adopt_photo_usecase.dart';
import '../../../domain/usecases/upload_pet_certificate_usecase.dart';

part 'edit_adopt_event.dart';
part 'edit_adopt_state.dart';

class EditAdoptBloc extends Bloc<EditAdoptEvent, EditAdoptState> {
  final UpdateAdoptUsecase updateAdoptUsecase;
  final UploadPetAdoptPhotoUsecase uploadPetPhoto;
  final UploadPetCertificateUsecase uploadPetCertificateUsecase;
  EditAdoptBloc({
    required this.updateAdoptUsecase,
    required this.uploadPetPhoto,
    required this.uploadPetCertificateUsecase,
  }) : super(EditAdoptInitial()) {
    on<SubmitUpdateAdopt>(
      (event, emit) async {
        // emit(EditAdoptLoading());
        try {
          String oldPhotoName = '';
          if (event.adoptEntityOld.petPictureUrl != null &&
              event.adoptEntityOld.petPictureUrl != '') {
            final result = TextGeneratorHelper.firestorageLinkRegex
                .allMatches(event.adoptEntityOld.petPictureUrl!)
                .map((e) => e.group(1))
                .toList();
            oldPhotoName = result[0] ?? '';
          }
          String petPhotoUrl = "";
          if (event.adoptEntityNew.petPictureUrl != null &&
              event.adoptEntityNew.petPictureUrl != '') {
            petPhotoUrl = basename(event.adoptEntityNew.petPictureUrl!);
          }
          if (petPhotoUrl != '' && petPhotoUrl != oldPhotoName) {
            petPhotoUrl = await uploadPetPhoto.execute(
                event.adoptEntityNew.petPictureUrl, oldPhotoName);
          }
          String oldCertificateName = '';
          String petCertificateUrl = "";
          if (event.adoptEntityOld.certificateUrl != null &&
              event.adoptEntityOld.certificateUrl != '') {
            final result = TextGeneratorHelper.firestorageLinkRegex
                .allMatches(event.adoptEntityOld.certificateUrl!)
                .map((e) => e.group(1))
                .toList();
            oldCertificateName = result[0] ?? '';
          }
          if (event.adoptEntityNew.certificateUrl != null &&
              event.adoptEntityNew.certificateUrl != '') {
            petCertificateUrl = basename(event.adoptEntityNew.certificateUrl!);
          }
          if (petCertificateUrl != '' &&
              petCertificateUrl != oldCertificateName) {
            petCertificateUrl = await uploadPetCertificateUsecase.execute(
                event.adoptEntityNew.certificateUrl!, oldCertificateName);
          }
          String petName = '';
          List<String> caseSearchList = [];
          if (event.adoptEntityNew.petName != event.adoptEntityOld.petName) {
            petName = event.adoptEntityNew.petName ?? '';
            String temp = "";
            for (int i = 0; i < petName.length; i++) {
              temp = temp + petName[i];
              caseSearchList.add(temp.toLowerCase());
            }
          }
          AdoptEntity adoptEntity = AdoptEntity(
            petName: petName,
            petType:
                event.adoptEntityNew.petType != event.adoptEntityOld.petType
                    ? event.adoptEntityNew.petType
                    : '',
            petTypeText: event.adoptEntityNew.petTypeText !=
                    event.adoptEntityOld.petTypeText
                ? event.adoptEntityNew.petTypeText
                : '',
            gender: event.adoptEntityNew.gender != event.adoptEntityOld.gender
                ? event.adoptEntityNew.gender
                : '',
            dateOfBirth: event.adoptEntityNew.dateOfBirth !=
                    event.adoptEntityOld.dateOfBirth
                ? event.adoptEntityNew.dateOfBirth
                : null,
            petDescription: event.adoptEntityNew.petDescription !=
                    event.adoptEntityOld.petDescription
                ? event.adoptEntityNew.petDescription
                : null,
            whatsappNumber: event.adoptEntityNew.whatsappNumber !=
                    event.adoptEntityOld.whatsappNumber
                ? event.adoptEntityNew.whatsappNumber
                : null,
            petBreed:
                event.adoptEntityNew.petBreed != event.adoptEntityOld.petBreed
                    ? event.adoptEntityNew.petBreed
                    : null,
            petPictureUrl: petPhotoUrl,
            certificateUrl: petCertificateUrl,
            adoptId: event.adoptEntityOld.adoptId,
            status: event.adoptEntityOld.status,
            titleSearch: caseSearchList.isNotEmpty ? caseSearchList : null,
          );

          await updateAdoptUsecase.execute(adoptEntity);
          emit(EditAdoptSuccess());
        } catch (_) {
          emit(EditAdoptError(message: 'failed edit open adopt'));
        }
      },
    );
    on<EditPetPhoto>(
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
            emit(EditPetPhotoSuccess(petPhotoPath: path));
          } else {
            emit(EditAdoptError(message: 'failed upload pet photo'));
          }
        } catch (_) {
          emit(EditAdoptError(message: 'failed upload pet photo'));
        }
      },
    );
    on<EditPetCertificate>(
      (event, emit) async {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'png'],
        );

        if (result != null) {
          if (result.files.first.size < 3000000) {
            String path = result.files.single.path ?? '';
            emit(EditPetCertificateSuccess(
              petCertificatePath: path,
              petCertificateFileName: basename(path),
            ));
          } else {
            emit(EditAdoptError(message: 'File Terlalu Besar'));
          }
        } else {
          emit(EditAdoptError(message: 'failed upload pet certificate'));
        }
      },
    );
  }
}
