import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/domain/usecases/add_pet_certificate_usecase.dart';
import 'package:pet/domain/usecases/add_pet_photo_usecase.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import '../../../domain/entities/pet_entity.dart';
import '../../../domain/usecases/add_pet_usecase.dart';

part 'add_pet_event.dart';
part 'add_pet_state.dart';

class AddPetBloc extends Bloc<AddPetEvent, AddPetState> {
  final AddPetUsecase addPetUsecase;
  final AddPetPhotoUsecase addPetPhotoUsecase;
  final AddPetCertificateUsecase addPetCertificateUsecase;

  AddPetBloc(
      {required this.addPetUsecase,
      required this.addPetPhotoUsecase,
      required this.addPetCertificateUsecase})
      : super(AddPetInitial()) {
    on<AddPetInitEvent>(
      (event, emit) {
        emit(AddPetInitial());
      },
    );
    on<SubmitAddPetEvent>((event, emit) async {
      emit(AddPetLoading());
      try {
        String petPhotoUrl = "";
        if (event.petEntity.petPictureUrl != null &&
            event.petEntity.petPictureUrl != '') {
          petPhotoUrl = await addPetPhotoUsecase.execute(
              event.petEntity.petPictureUrl, '');
        }
        String petCertificateUrl = "";
        if (event.petEntity.certificateUrl != null &&
            event.petEntity.certificateUrl != '') {
          petCertificateUrl = await addPetCertificateUsecase.execute(
              event.petEntity.certificateUrl!, '');
        }
        PetEntity petEntity = PetEntity(
          petName: event.petEntity.petName,
          petType: event.petEntity.petType,
          gender: event.petEntity.gender,
          dateOfBirth: event.petEntity.dateOfBirth,
          petDescription: event.petEntity.petDescription,
          petBreed: event.petEntity.petBreed,
          petPictureUrl: petPhotoUrl,
          petTypeText: event.petEntity.petTypeText,
          certificateUrl: petCertificateUrl,
        );

        await addPetUsecase.execute(petEntity);
        emit(AddPetSuccess());
      } catch (e) {
        emit(AddPetError(message: 'error'));
      }
    });

    on<AddPetPhotoEvent>(
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
            emit(AddPetPhotoSuccess(petPhotoPath: path));
          } else {
            emit(AddPetError(message: 'failed upload pet photo'));
          }
        } catch (_) {
          emit(AddPetError(message: 'failed upload pet photo'));
        }
      },
    );
    on<AddPetCertificateEvent>(
      (event, emit) async {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'png'],
        );

        if (result != null) {
          if (result.files.first.size < 2000000) {
            String path = result.files.single.path ?? '';
            emit(AddPetCertificateSuccess(
                petCertificatePath: path,
                petCertificateFileName: basename(path)));
          } else {
            emit(AddPetError(message: 'File Terlalu Besar'));
          }
        } else {
          emit(AddPetError(message: 'failed upload pet certificate'));
        }
      },
    );
  }
}
