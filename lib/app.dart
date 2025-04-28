// app.dart
import 'package:delala/config/routes/app_router.dart';
import 'package:delala/features/auth/sign_in/domain/usecases/sign_in.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_bloc.dart';
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/home/presentation/bloc/home_bloc.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';
import 'package:delala/features/products/presentation/bloc/products_bloc.dart';
import 'package:delala/features/todo/presentation/todo_bloc/todo_bloc.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:delala/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:brave/config/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<CategoryBloc>()),
          BlocProvider(create: (_) => sl<HomeBloc>()),
          BlocProvider(create: (context) => TodoBloc(sl())),
          BlocProvider(create: (context) => SignUpBloc(sl())),
          BlocProvider(create: (context) => SignInBloc(sl<SignIn>())),
          BlocProvider(create: (context) => sl<ProductBloc>()),
        ],
        child: MaterialApp.router(
          // darkTheme: darkTheme,
          // theme: lightTheme,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
