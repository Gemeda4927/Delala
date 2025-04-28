import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:delala/features/auth/sign_up/domain/use_case/signup_use_case.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc(this.signUpUseCase) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        // Check network connectivity
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          emit(
            AuthFailure(
              error:
                  "No internet connection. Please check your network and try again.",
            ),
          );
          return;
        }

        // Execute the sign-up use case
        final response = await signUpUseCase.execute(event.user);
        final data = response.data as Map<String, dynamic>;
        emit(
          AuthSuccess(
            message: data['message'] ?? 'Sign up successful!',
            userId: data['userId'],
          ),
        );
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          emit(
            AuthFailure(
              error:
                  "Network error: Unable to connect to the server. Please check your internet connection.",
            ),
          );
        } else if (e.response != null) {
          // Handle server-side errors (e.g., 400, 500)
          final errorMessage =
              e.response?.data['message'] ?? 'An error occurred on the server.';
          emit(AuthFailure(error: "Sign up failed: $errorMessage"));
        } else {
          emit(
            AuthFailure(
              error: "Sign up failed: ${e.message ?? 'Unknown error'}",
            ),
          );
        }
      } catch (e) {
        emit(AuthFailure(error: "An unexpected error occurred: $e"));
      }
    });
  }
}
