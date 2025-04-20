import '../entities/user.dart';

abstract class AuthRepository {
  Future<String> login(String username, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
}