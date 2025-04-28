import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://mercent-api.onrender.com',
            connectTimeout: Duration(seconds: 30),
            receiveTimeout: Duration(seconds: 30),
          ),
        )..interceptors.addAll([
            InterceptorsWrapper(
              onRequest: (options, handler) {
                // Add auth token if available
                final token = ''; // Get from secure storage
                if (token.isNotEmpty) {
                  options.headers['Authorization'] = 'Bearer $token';
                }
                return handler.next(options);
              },
              onError: (error, handler) {
                // Handle errors globally
                return handler.next(error);
              },
            ),
          ]);

  Dio get dio => _dio;
}
