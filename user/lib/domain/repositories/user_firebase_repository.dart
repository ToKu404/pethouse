import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<UserCredential?> signIn(String email, String password);
  Future<UserCredential?> signInWithGoogle();

  Future<UserCredential?> signUp(String name, String email, String password);
  Future<bool> isSignIn();
  Future<String> retrieveUid();
  Future<void> signOut();
  Future<void> saveUserData(UserEntity user);
  Future<void> updateUserDate(UserEntity user);
  Stream<UserEntity> getCurrentUser(String uid);
  Future<String> uploadImage(XFile imageFile);
  Future<void> deleteOldImage(String oldImageUrl);
  Future<void> resetPassword(String email);
  Future<void> verifyEmail();
  Future<void> deleteUser(UserEntity user);
}
