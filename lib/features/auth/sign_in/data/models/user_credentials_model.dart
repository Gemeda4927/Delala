import 'package:delala/features/auth/sign_in/domain/entities/user_credentials.dart';

class UserCredentialsModel extends UserCredentials {
  UserCredentialsModel({
    required super.email,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
