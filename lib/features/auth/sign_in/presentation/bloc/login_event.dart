// presentation/bloc/auth/auth_event.dart
import 'package:delala/features/auth/sign_in/domain/entities/user_credentials.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final UserCredentials credentials;

  SignInEvent(this.credentials);
}