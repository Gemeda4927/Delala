import 'package:delala/features/auth/sign_in/domain/entities/user_credentials.dart';
import 'package:delala/features/auth/sign_in/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<Map<String, dynamic>> call(UserCredentials credentials) async {
    return await repository.signIn(credentials);
  }
}