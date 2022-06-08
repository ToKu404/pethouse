import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource firebaseDataSource;

  UserRepositoryImpl({required this.firebaseDataSource});
  @override
  Future<UserCredential?> signIn(String email, String password) async {
    return firebaseDataSource.signIn(email, password);
  }

  @override
  Future<bool> isSignIn() async {
    return firebaseDataSource.isSignIn();
  }

  @override
  Future<String> retrieveUid() {
    return firebaseDataSource.getUserId();
  }

  @override
  Future<void> signOut() async {
    return await firebaseDataSource.signOut();
  }

  @override
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    return await firebaseDataSource.signUp(name, email, password);
  }

  @override
  Future<void> saveUserData(UserEntity user) async {
    return await firebaseDataSource.saveUserData(user);
  }

  @override
  Stream<UserEntity> getCurrentUser(String uid) {
    return firebaseDataSource.getCurrentUser(uid);
  }

  @override
  Future<String> uploadImage(XFile imageFile) async {
    return firebaseDataSource.uploadImage(imageFile);
  }

  @override
  Future<void> updateUserData(UserEntity user) async {
    return firebaseDataSource.updateUserData(user);
  }

  @override
  Future<void> deleteOldImage(String oldImageUrl) {
    return firebaseDataSource.deleteOldImage(oldImageUrl);
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    return firebaseDataSource.signInWithGoogle();
  }

  @override
  Future<void> resetPassword(String email) async {
    return await firebaseDataSource.resetPassword(email);
  }

  @override
  Future<void> verifyEmail() async {
    return await firebaseDataSource.sendEmailVerification();
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    return await firebaseDataSource.deleteUser(user);
  }

  @override
  Future<void> saveUserIdToLocal(String userId) async {
    return await firebaseDataSource.saveUserIdToLocal(userId);
  }

  @override
  Future<void> removeUserIdLocal() async {
    return await firebaseDataSource.removeUserIdLocal();
  }
}
