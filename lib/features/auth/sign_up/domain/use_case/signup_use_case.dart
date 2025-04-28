
import 'package:delala/features/auth/sign_up/data/model/user_model.dart';
import 'package:delala/features/auth/sign_up/domain/repository/auth_repo.dart';
import 'package:dio/dio.dart';

class SignUpUseCase {
  final AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  Future<Response> execute(UserModel user) async {
    return await authRepo.signUp(user);
  }
}