// data/services/sign_in_service.dart
import 'package:delala/core/handlers/dio_client.dart';
import 'package:dio/dio.dart';

class SignInService {
  final DioClient apiService;
  static bool _isAuthenticated = true;
  static String? _token;

  SignInService(this.apiService);

  Future<Response> signIn(String email, String password) async {
    try {
      final response = await apiService.dio.post(
        '/auth/signin',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isAuthenticated = true;
        _token = response.data['token'] ?? '';
      }

      return response;
    } on DioException catch (e) {
      print('Error Response Data: ${e.response?.data}');
      print('Error Response Status: ${e.response?.statusCode}');

      if (e.response != null) {
        throw 'Invalid email or password';
      } else {
        throw 'Sign in failed: Network error - ${e.message}';
      }
    } catch (e) {
      throw 'Sign in failed: Unexpected error - $e';
    }
  }

  static bool isAuthenticated() {
    return _isAuthenticated;
  }

  static void setAuthenticated(bool value) {
    _isAuthenticated = value;
    if (!value) {
      _token = null;
    }
  }

  static String? getToken() {
    return _token;
  }

  static void signOut() {
    _isAuthenticated = false;
    _token = null;
  }

  static void logout() {}

  static getUserName() {}
}
