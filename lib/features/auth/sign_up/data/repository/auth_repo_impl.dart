
import 'package:delala/features/auth/sign_up/data/model/user_model.dart';
import 'package:delala/features/auth/sign_up/domain/repository/auth_repo.dart';
import 'package:delala/features/auth/sign_up/data/services/auth_service.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl(this.authService);

  @override
  Future<Response> signUp(UserModel user) async {
    try {
      return await authService.signUp(user); 
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }
}
