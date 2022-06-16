import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/firestore_usecases/delete_old_image_usecase.dart';
import '../../../domain/usecases/firestore_usecases/update_user_data_usecase.dart';
import '../../../domain/usecases/storage_usecases/upload_image_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileValidate> {
  final UploadImageUsecase uploadImageUsecase;
  final UpdateUserDataUsecase updateUserDataUsecase;
  final DeleteOldImageUsecase deleteOldImageUsecase;
  UserProfileBloc(
      {required this.uploadImageUsecase,
      required this.updateUserDataUsecase,
      required this.deleteOldImageUsecase})
      : super(const UserProfileValidate(
            imageUrl: '',
            imageIsUpload: false,
            isLoading: false,
            email: '',
            name: '',
            isEmailValid: true,
            isNameValid: true,
            isFormValid: false,
            oldImageUrl: '')) {
    on<UserProfileInit>(_onInitUserProfile);
    on<ImageUploaded>(_onImagePicking);
    on<UserEmailChanged>(_onEmailChanged);
    on<UserNameChanged>(_onNameChanged);
    on<SubmitUpdate>(_onSubmitUpdate);
  }

  void _onInitUserProfile(
      UserProfileInit event, Emitter<UserProfileValidate> emit) {
    emit(state.copyWith(
      imageUrl: event.imageUrl,
      imageIsUpload: false,
      isLoading: false,
      email: event.email,
      name: event.name,
      isEmailValid: true,
      isNameValid: true,
      isFormValid: false,
    ));
  }

  void _onImagePicking(
      ImageUploaded event, Emitter<UserProfileValidate> emit) async {
    emit(state.copyWith(isLoading: true));
    ImageSource source = ImageSource.gallery;
    XFile? file =
        await ImagePicker().pickImage(source: source, imageQuality: 80);
    if (file != null) {
      final imageUrl = await uploadImageUsecase.execute(file);
      await updateUserDataUsecase.execute(UserEntity(
          name: null, email: null, imageUrl: imageUrl, uid: event.userId));
      emit(state.copyWith(
          imageUrl: imageUrl,
          imageIsUpload: true,
          isLoading: false,
          oldImageUrl: event.oldImageUrl));
    }
  }

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isNameValid(String? displayName) {
    return displayName!.isNotEmpty;
  }

  _onEmailChanged(UserEmailChanged event, Emitter<UserProfileValidate> emit) {
    emit(
      state.copyWith(
        isFormValid: false,
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      ),
    );
  }

  _onNameChanged(UserNameChanged event, Emitter<UserProfileValidate> emit) {
    emit(state.copyWith(
      isFormValid: false,
      name: event.name,
      isNameValid: _isNameValid(event.name),
    ));
  }

  _onSubmitUpdate(SubmitUpdate event, Emitter<UserProfileValidate> emit) async {
    emit(state.copyWith(
        isFormValid: _isEmailValid(state.email) && _isNameValid(state.name),
        isLoading: true));
    if (state.isFormValid) {
      try {
        if (state.oldImageUrl != '') {
          await deleteOldImageUsecase.execute(state.oldImageUrl);
        }
        await updateUserDataUsecase.execute(UserEntity(
            name: state.name,
            email: state.email,
            imageUrl: state.imageIsUpload ? state.imageUrl : null,
            uid: event.userId));
        emit(state.copyWith(isLoading: false));
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }
  }
}
