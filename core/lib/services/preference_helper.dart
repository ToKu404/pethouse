import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/data/models/user_model.dart';
import 'package:user/user.dart';

class PreferenceHelper {
  static PreferenceHelper? _preferenceHelper;
  PreferenceHelper._instance() {
    _preferenceHelper = this;
  }
  static SharedPreferences? _preferences;

  Future<SharedPreferences?> get preferences async {
    _preferences ??= await _initPreference();
    return _preferences;
  }

  factory PreferenceHelper() =>
      _preferenceHelper ?? PreferenceHelper._instance();

  static SharedPreferences? sharedPreferences;

  Future<SharedPreferences> _initPreference() async {
    final pr = await SharedPreferences.getInstance();
    return pr;
  }

  static const userIdKey = 'USER_ID';
  // static const userDataKey = 'USER_DATA';

  Future<bool> checkUserIdExist() async {
    final pr = await preferences;
    return pr!.containsKey(userIdKey) ? true : false;
  }

  Future<bool> setUserId(String userId) async {
    final pr = await preferences;
    return pr!.setString(userIdKey, userId);
  }

  Future<String> getUserId() async {
    final pr = await preferences;
    String? userId = pr!.getString(userIdKey);

    return userId!;
  }

  Future<bool> removeUserId() async {
    final pr = await preferences;
    return pr!.remove(userIdKey);
  }

  // Future<UserEntity> getUserData() async {
  //   final pr = await preferences;
  //   String? user = pr!.getString(userDataKey);
  //   if (user != null) {
  //     Map<String, dynamic> userMap = json.decode(user);
  //     UserEntity userEntity = UserModel.fromJson(userMap);
  //     return userEntity;
  //   }
  //   return const UserEntity(name: '', email: '');
  // }

  // Future<bool> removeUserData() async {
  //   final pr = await preferences;
  //   return pr!.remove(userDataKey);
  // }

  // Future<bool> setUserData(UserEntity userEntity) async {
  //   final pr = await preferences;

  //   if (pr!.containsKey(userDataKey)) {
  //     return false;
  //   }
  //   String user = jsonEncode(UserModel(
  //           name: userEntity.name,
  //           email: userEntity.email,
  //           imgUrl: userEntity.imageUrl,
  //           uid: userEntity.uid)
  //       .toJson());
  //   return await pr.setString(userDataKey, user);
  // }

  // Future<void> updateUserData(UserEntity userEntity) async {
  //   final pr = await preferences;
  //   String? userString = pr!.getString(userDataKey);
  //   Map<String, dynamic> userMap = json.decode(userString!);
  //   if (userEntity.imageUrl != null && userEntity.imageUrl != '') {
  //     userMap['img_url'] = userEntity.imageUrl;
  //   }
  //   if (userEntity.email != null) {
  //     userMap['email'] = userEntity.email;
  //   }
  //   if (userEntity.name != null) userMap['name'] = userEntity.name;
  //   await removeUserData();
  //   await pr.setString(userDataKey, jsonEncode(userMap));
  // }
}
