import '../repositories/auth_repository.dart';

class IsLoggedIn {
  final AuthRepository repository;

  IsLoggedIn(this.repository);

  Future<bool> execute() async {
    return await repository.isLoggedIn();
  }
}