import 'package:adopt/data/data_sources/adopt_data_source.dart';
import 'package:adopt/data/repositories/adopt_repository_impl.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';
import 'package:adopt/domain/usecases/create_new_adopt_usecase.dart';
import 'package:adopt/domain/usecases/get_all_pet_list_usecase.dart';
import 'package:adopt/domain/usecases/get_pet_description_usecase.dart';
import 'package:adopt/domain/usecases/get_user_id_local_usecase.dart';
import 'package:adopt/domain/usecases/upload_pet_adopt_photo_usecase.dart';
import 'package:adopt/domain/usecases/upload_pet_certificate_usecase.dart';
import 'package:adopt/presentation/blocs/detail_adopt_bloc/detail_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/list_adopt_bloc/list_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/pet_adopt_bloc/pet_adopt_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pet/data/data_sources/pet_firebase_data_source.dart';
import 'package:pet/data/repositories/pet_firebase_repository_impl.dart';
import 'package:pet/domain/repositories/pet_firebase_repository.dart';
import 'package:pet/domain/usecases/add_certificate_usecase.dart';
import 'package:pet/domain/usecases/add_pet_usecase.dart';
import 'package:pet/domain/usecases/add_photo_usecase.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import 'package:schedule/activity/data/data_sources/task_firebase_data_source.dart';
import 'package:schedule/activity/data/repositories/task_firebase_repository_impl.dart';
import 'package:schedule/activity/domain/repositories/medicaladd_firebase_repository.dart';
import 'package:schedule/activity/domain/repositories/taskadd_firebase_repository.dart';
import 'package:schedule/activity/domain/use_cases/medicaladd_usecase.dart';
import 'package:schedule/activity/domain/use_cases/task_add_usecase.dart';
import 'package:schedule/activity/presentation/blocs/addmedical_bloc/medical_bloc.dart';
import 'package:schedule/activity/presentation/blocs/addtask_bloc/task_bloc.dart';
import 'package:user/data/data_sources/user_data_source.dart';
import 'package:user/data/repositories/user_repository_impl.dart';
import 'package:user/domain/repositories/user_repository.dart';
import 'package:user/domain/usecases/auth_usecases/delete_user_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/get_user_id_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/is_sign_in_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/remove_user_id_local_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/reset_password_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/save_user_id_local_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_in_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_in_with_google_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/verify_email_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/delete_old_image_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/get_current_user_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/save_user_data_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/update_user_data_usecase.dart';
import 'package:user/domain/usecases/storage_usecases/upload_image_usecase.dart';
import 'package:user/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:user/presentation/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:user/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:user/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'package:user/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:schedule/activity/data/repositories/medical_firebase_repository_impl.dart';
import 'package:schedule/activity/data/data_sources/medical_firebase_data_source.dart';

final locator = GetIt.instance;

void init() {
  // repositoriy
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(firebaseDataSource: locator()));
  locator.registerLazySingleton<MedicalFirebaseRepository>(() =>
      MedicalFirebaseRepositoryImpl(medicalFirebaseDataSource: locator()));
  locator.registerLazySingleton<TaskFirebaseRepository>(
      () => TaskFirebaseRepositoryImpl(taskFirebaseDataSource: locator()));
  locator.registerLazySingleton<PetFirebaseRepository>(
      () => PetFirebaseRepositoryImpl(petFirebaseDataSource: locator()));
  locator.registerLazySingleton<AdoptRepository>(
      () => AdoptRepositoryImpl(adoptDataSource: locator()));

  // datasource
  locator.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
      firebaseAuth: locator(),
      firebaseFirestore: locator(),
      firebaseStorage: locator()));
  locator.registerLazySingleton<MedicalFirebaseDataSource>(
      () => MedicalFirebaseDataSourceImpl(medicalFireStore: locator()));
  locator.registerLazySingleton<TaskFirebaseDataSource>(
      () => TaskFirebaseDataSourceImpl(taskFireStore: locator()));
  locator.registerLazySingleton<PetFirebaseDataSource>(() =>
      PetFirebaseDataSourceImpl(
          petFireStore: locator(), firebaseStorage: locator()));
  locator.registerLazySingleton<AdoptDataSource>(() => AdoptDataSourceImpl(
        firebaseFirestore: locator(),
        firebaseStorage: locator(),
        firebaseAuth: locator(),
      ));

  // usecases
  locator.registerLazySingleton(
      () => SignInUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => IsSignInUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => GetUserIdUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => SignOutUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => SignUpUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => GetCurrentUserUsecase(firebaseRepository: locator()));
  locator
      .registerLazySingleton(() => SaveUserData(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => UploadImageUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => UpdateUserDataUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(() => DeleteOldImageUsecase(locator()));
  locator.registerLazySingleton(
      () => SignInWithGoogle(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => ResetPasswordUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => VerifyEmailUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => DeleteUserUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => AddMedicalUseCase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => AddTaskUseCase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => AddPetUseCase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => AddPhotoUseCase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => AddCertificateUseCase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => CreateNewAdoptUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(() => SaveUserIdLocal(repository: locator()));
  locator.registerLazySingleton(
      () => RemoveUserIdLocalUsecase(userRepository: locator()));
  locator.registerLazySingleton(
      () => UploadPetAdoptPhotoUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => UploadPetCertificateUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetAllPetListUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetPetDescriptionUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetUserIdLocalUsecase(adoptRepository: locator()));

  // bloc & cubit
  locator.registerFactory(
      () => SignInBloc(signInUsecase: locator(), signInWithGoogle: locator()));
  locator.registerFactory(() => SignUpBloc(
      signUpUsecase: locator(),
      saveUserData: locator(),
      verifyEmailUsecase: locator()));
  locator.registerFactory(
      () => ResetPasswordBloc(resetPasswordUsecase: locator()));
  locator.registerFactory(() => AuthCubit(
      isSignInUsecase: locator(),
      getUserIdUsecase: locator(),
      signOutUsecase: locator(),
      removeUserIdLocalUsecase: locator(),
      saveUserIdLocal: locator()));
  locator.registerFactory(
      () => UserDbBloc(getUserFromDb: locator(), deleteUserUsecase: locator()));
  locator.registerFactory(() => UserProfileBloc(
      uploadImageUsecase: locator(),
      updateUserDataUsecase: locator(),
      deleteOldImageUsecase: locator()));

  locator.registerFactory(() => MedicalBloc(addMedicalUsecase: locator()));
  locator.registerFactory(() => TaskBloc(addTaskUsecase: locator()));
  locator.registerFactory(() => AddPetBloc(
        addPetUsecase: locator(),
        addPhotoUsecase: locator(),
        addCertificateUsecase: locator(),
      ));
  locator.registerFactory(() => PetAdoptBloc(
        createNewAdoptUsecase: locator(),
        uploadPetPhoto: locator(),
        uploadPetCertificateUsecase: locator(),
      ));

  locator.registerFactory(() => DetailAdoptBloc(
        getPetDescriptionUsecase: locator(),
        getUserIdLocalUsecase: locator(),
      ));
  locator.registerFactory(() => ListAdoptBloc(getAllPetListUsecase: locator()));

  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => firestore);
  locator.registerLazySingleton(() => storage);
}
