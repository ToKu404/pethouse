// ignore_for_file: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/usecases/add_pet_certificate_usecase.dart';
import 'package:pet/domain/usecases/add_pet_photo_usecase.dart';
import 'package:pet/domain/usecases/update_pet_usecase.dart';

part 'update_pet_event.dart';
part 'update_pet_state.dart';

class UpdatePetBloc extends Bloc<UpdatePetEvent, UpdatePetState> {
  final UpdatePetUsecase updatePetUsecase;
  final AddPetPhotoUsecase addPetPhotoUsecase;
  final AddPetCertificateUsecase addPetCertificateUsecase;
  UpdatePetBloc(
      {required this.updatePetUsecase,
      required this.addPetCertificateUsecase,
      required this.addPetPhotoUsecase})
      : super(UpdatePetInitial()) {
    on<SubmitUpdatePetEvent>(
      (event, emit) async {
        try {
          final firebaseRegex = RegExp(r'%2F([\d\D]*\.[\D]+)\?',
              multiLine: false, caseSensitive: false);
          String oldPhotoName = '';
          if (event.petEntityOld.petPictureUrl != null &&
              event.petEntityOld.petPictureUrl != '') {
            final result = firebaseRegex
                .allMatches(event.petEntityOld.petPictureUrl!)
                .map((e) => e.group(1))
                .toList();
            oldPhotoName = result[0] ?? '';
          }
          String petPhotoUrl = "";
          if (event.petEntityNew.petPictureUrl != null &&
              event.petEntityNew.petPictureUrl != '') {
            petPhotoUrl = basename(event.petEntityNew.petPictureUrl!);
          }
          if (petPhotoUrl != '' && petPhotoUrl != oldPhotoName) {
            petPhotoUrl = await addPetPhotoUsecase.execute(
                event.petEntityNew.petPictureUrl, oldPhotoName);
          }
          String oldCertificateName = '';
          String petCertificateUrl = "";
          if (event.petEntityOld.certificateUrl != null &&
              event.petEntityOld.certificateUrl != '') {
            final result = firebaseRegex
                .allMatches(event.petEntityOld.certificateUrl!)
                .map((e) => e.group(1))
                .toList();
            oldCertificateName = result[0] ?? '';
          }
          if (event.petEntityNew.certificateUrl != null &&
              event.petEntityNew.certificateUrl != '') {
            petCertificateUrl = basename(event.petEntityNew.certificateUrl!);
          }
          if (petCertificateUrl != '' &&
              petCertificateUrl != oldCertificateName) {
            petCertificateUrl = await addPetCertificateUsecase.execute(
                event.petEntityNew.certificateUrl!, oldCertificateName);
          }

          PetEntity petEntity = PetEntity(
            petName: event.petEntityNew.petName != event.petEntityOld.petName
                ? event.petEntityNew.petName
                : '',
            petType: event.petEntityNew.petType != event.petEntityOld.petType
                ? event.petEntityNew.petType
                : '',
            gender: event.petEntityNew.gender != event.petEntityOld.gender
                ? event.petEntityNew.gender
                : '',
            petTypeText:
                event.petEntityNew.petTypeText != event.petEntityOld.petTypeText
                    ? event.petEntityNew.petTypeText
                    : '',
            dateOfBirth:
                event.petEntityNew.dateOfBirth != event.petEntityOld.dateOfBirth
                    ? event.petEntityNew.dateOfBirth
                    : null,
            petDescription: event.petEntityNew.petDescription !=
                    event.petEntityOld.petDescription
                ? event.petEntityNew.petDescription
                : null,
            petBreed: event.petEntityNew.petBreed != event.petEntityOld.petBreed
                ? event.petEntityNew.petBreed
                : null,
            petPictureUrl: petPhotoUrl,
            certificateUrl: petCertificateUrl,
            id: event.petEntityOld.id,
            userId: event.petEntityOld.userId,
          );

          await updatePetUsecase.execute(petEntity);
          emit(UpdatePetSuccess());
        } catch (_) {
          emit(UpdatePetError(message: 'failed edit open adopt'));
        }
      },
    );
    on<UpdatePetPhoto>(
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
            emit(UpdatePetPhotoSuccess(petPhotoPath: path));
          } else {
            emit(UpdatePetError(message: 'failed upload pet photo'));
          }
        } catch (_) {
          emit(UpdatePetError(message: 'failed upload pet photo'));
        }
      },
    );
  }
}
