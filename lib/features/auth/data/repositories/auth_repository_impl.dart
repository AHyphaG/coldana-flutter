import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<String> login(String username, String password) async {
    try{
      final response = await remoteDataSource.login(username, password);
      final token = response['token'] as String;

      // Cache token in SharedPreferences
      await localDataSource.cacheToken(token);

      return token;
    }catch(e){
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await localDataSource.getToken();
    return token != null;
  }
}