import 'dart:convert';
import 'package:coldana_flutter/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource{
  Future<void> cacheToken(String token);
  Future<void> cacheUser(UserModel user);
  Future<String?> getToken();
  Future<UserModel?> getUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(String token) {
    return sharedPreferences.setString('TOKEN', token);
  }

  @override
  Future<void> cacheUser(UserModel user) {
    return sharedPreferences.setString('USER', json.encode(user.toJson()));
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('TOKEN');
  }

  @override
  Future<UserModel?> getUser() {
    final userString = sharedPreferences.getString('USER');
    if (userString != null) {
      return Future.value(UserModel.fromJson(json.decode(userString)));
    }
    return Future.value(null);
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove('TOKEN');
    await sharedPreferences.remove('USER');
  }

}