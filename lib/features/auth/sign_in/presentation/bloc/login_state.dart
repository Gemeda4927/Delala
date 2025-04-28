// features/auth/sign_in/presentation/bloc/login_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> userData; // Adjust based on your API response

  AuthSuccess(this.userData);
}

class AuthFailure extends AuthState {
  final String error; // Ensure this is a String, not an int

  AuthFailure(this.error);
}
