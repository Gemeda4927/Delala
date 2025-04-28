
// Events
import 'package:delala/features/auth/sign_up/data/model/user_model.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final UserModel user;

  SignUpEvent(this.user);
}