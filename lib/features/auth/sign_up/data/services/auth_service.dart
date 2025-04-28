import 'package:delala/core/handlers/dio_client.dart';
import 'package:delala/features/auth/sign_up/data/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final DioClient apiService;

  AuthService(this.apiService);

  Future<Response> signUp(UserModel user) async {
    try {
      final response = await apiService.dio.post(
        '/auth/signup',
        data: user.toJson(),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
