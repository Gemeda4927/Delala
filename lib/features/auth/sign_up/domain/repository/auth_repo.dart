
import 'package:delala/features/auth/sign_up/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRepo {
  Future<Response> signUp(UserModel user);
}