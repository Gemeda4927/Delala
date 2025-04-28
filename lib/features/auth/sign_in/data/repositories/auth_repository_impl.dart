// data/repositories/auth_repository_impl.dart
import 'package:delala/features/auth/sign_in/data/Service/auth_service.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/user_credentials.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SignInService signInService;

  AuthRepositoryImpl(this.signInService);

  @override
  Future<Map<String, dynamic>> signIn(UserCredentials credentials) async {
    try {
      final response = await signInService.signIn(
        credentials.email,
        credentials.password,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to sign in');
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }
}
