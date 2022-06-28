import 'dart:io';
import 'package:core/services/preference_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<UserCredential?> signIn(String email, String password);
  Future<UserCredential?> signInWithGoogle();
  Future<bool> isSignIn();
  Future<String> getUserId();
  Future<void> signOut();
  Future<UserCredential?> signUp(String name, String email, String password);
  Future<void> saveUserData(UserEntity user);
  Future<void> updateUserData(UserEntity user);
  Stream<UserEntity> getCurrentUser(String uid);
  Future<String> uploadImage(XFile imageFile);
  Future<void> deleteOldImage(String oldImageUrl);
  Future<void> resetPassword(String email);
  Future<void> sendEmailVerification();
  Future<void> deleteUser(UserEntity user);
  Future<void> saveUserIdToLocal(String userId);
  Future<void> removeUserIdLocal();
  Future<void> saveDataToLocal(UserEntity userEntity);
  Future<UserEntity> getUserDataLocal();
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final PreferenceHelper preferenceHelper;

  UserDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
    required this.preferenceHelper,
  });

  @override
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<bool> isSignIn() async {
    return preferenceHelper.checkUserIdExist();
  }

  @override
  Future<String> getUserId() async {
    if (firebaseAuth.currentUser?.uid != null) {
      return firebaseAuth.currentUser!.uid;
    } else {
      return "";
    }
  }

  @override
  Future<void> signOut() async {
    final statusGoogle = await GoogleSignIn().isSignedIn();
    if (statusGoogle) {
      await GoogleSignIn().signOut();
    }
    return await firebaseAuth.signOut();
  }

  @override
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
    return null;
  }

  @override
  Future<void> saveUserData(UserEntity user) async {
    final userCollectionRef = firebaseFirestore.collection("users");
    final uid = firebaseAuth.currentUser?.uid;
    final notifCollection = firebaseFirestore.collection('notifications');

    Map<String, dynamic> notif = {};
    notif['all_notif'] = [];
    notif['notif_id'] = uid;
    await notifCollection.doc(uid).get().then((value) {
      if (!value.exists) {
        notifCollection.doc(uid).set(notif);
      }
    });
    await userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
              uid: uid,
              email: user.email,
              name: user.name,
              imgUrl: user.imageUrl)
          .toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Stream<UserEntity> getCurrentUser(String uid) {
    final snapshot = firebaseFirestore.collection("users").doc(uid).snapshots();
    return snapshot.map((value) {
      final user = UserModel.fromSnapshot(value);
      return user;
    });
  }

  @override
  Future<String> uploadImage(XFile imageFile) async {
    String filename = basename(imageFile.path);
    final ref = firebaseStorage.ref().child('user_photos').child(filename);
    await ref.putFile(File(imageFile.path));
    return await ref.getDownloadURL();
  }

  @override
  Future<void> updateUserData(UserEntity user) async {
    Map<String, dynamic> userMap = {};
    final userCollectionRef = firebaseFirestore.collection('users');
    if (user.imageUrl != null && user.imageUrl != '') {
      userMap['img_url'] = user.imageUrl;
    }
    if (user.email != null) {
      userMap['email'] = user.email;
      await firebaseAuth.currentUser?.updateEmail(user.email ?? '');
    }

    if (user.name != null) userMap['name'] = user.name;
    userCollectionRef.doc(user.uid).update(userMap);
    await updateLocalUserData(user);
  }

  @override
  Future<void> deleteOldImage(String oldImageUrl) async {
    if (oldImageUrl != '') {
      final desertRef = firebaseStorage.refFromURL(oldImageUrl);
      await desertRef.delete();
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential? userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      final userCollectionRef = firebaseFirestore.collection("users");
      final notifCollection = firebaseFirestore.collection("notifications");
      Map<String, dynamic> notif = {};
      notif['all_notif'] = [];
      notif['notif_id'] = user.uid;
      notifCollection.doc(user.uid).get().then((value) {
        if (!value.exists) {
          notifCollection.doc(user.uid).set(notif);
        }
      });
      userCollectionRef.doc(user.uid).get().then((value) {
        final newUser = UserModel(
                uid: user.uid,
                email: user.email,
                name: user.displayName,
                imgUrl: user.photoURL)
            .toDocument();
        if (!value.exists) {
          userCollectionRef.doc(user.uid).set(newUser);
        }
      });
    }
    return userCredential;
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    // delete storage
    if (user.imageUrl != null && user.imageUrl != "") {
      await deleteOldImage(user.imageUrl ?? '');
    }
    // delete data from firestore
    try {
      await firebaseFirestore.collection("users").doc(user.uid).delete();
    } catch (_) {}
    // delete from auth
    return await firebaseAuth.currentUser?.delete();
  }

  @override
  Future<void> saveUserIdToLocal(String userId) async {
    await preferenceHelper.setUserId(userId);
  }

  @override
  Future<void> removeUserIdLocal() async {
    await preferenceHelper.removeUserId();
    await preferenceHelper.removeUserData();
    return;
  }

  @override
  Future<void> saveDataToLocal(UserEntity userEntity) async {
    await preferenceHelper.setUserData(userEntity);
    return;
  }

  @override
  Future<UserEntity> getUserDataLocal() async {
    final result = await preferenceHelper.getUserData();
    print("NAMEEEEE ${result.name}");
    return result;
  }

  Future<void> updateLocalUserData(UserEntity user) async {
    await preferenceHelper.updateUserData(user);
    if (user.email != null) {
      await firebaseAuth.currentUser?.updateEmail(user.email ?? '');
    }
  }
}
