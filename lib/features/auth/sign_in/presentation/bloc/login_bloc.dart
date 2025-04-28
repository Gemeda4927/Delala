// presentation/bloc/auth/auth_bloc.dart

import 'package:delala/features/auth/sign_in/domain/usecases/sign_in.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_event.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;

  SignInBloc(this.signIn) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await signIn(event.credentials);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
