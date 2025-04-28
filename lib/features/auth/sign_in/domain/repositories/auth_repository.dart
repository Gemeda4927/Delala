import 'package:delala/features/auth/sign_in/domain/entities/user_credentials.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> signIn(UserCredentials credentials);
}