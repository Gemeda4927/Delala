import 'package:delala/core/handlers/dio_client.dart';
import 'package:delala/features/auth/sign_in/data/Service/auth_service.dart';
import 'package:delala/features/auth/sign_in/data/repositories/auth_repository_impl.dart';
import 'package:delala/features/auth/sign_in/domain/repositories/auth_repository.dart';
import 'package:delala/features/auth/sign_in/domain/usecases/sign_in.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_bloc.dart';
import 'package:delala/features/auth/sign_up/data/repository/auth_repo_impl.dart';
import 'package:delala/features/auth/sign_up/data/services/auth_service.dart';
import 'package:delala/features/auth/sign_up/domain/repository/auth_repo.dart';
import 'package:delala/features/auth/sign_up/domain/use_case/signup_use_case.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:delala/features/categories/data/repositories/category_repository_impl.dart';
import 'package:delala/features/categories/data/services/category.dart';
import 'package:delala/features/categories/domain/repositories/category_repository.dart';
import 'package:delala/features/categories/domain/usecases/category_usecases.dart'
    as category_usecases;
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/home/data/service/home_services.dart';
import 'package:delala/features/home/data/repositories/home_repository_impl.dart';
import 'package:delala/features/home/domain/repositories/home_repository.dart';
import 'package:delala/features/home/domain/usecases/get_home_data.dart'
    as home_usecases;
import 'package:delala/features/home/presentation/bloc/home_bloc.dart';
import 'package:delala/features/products/data/repository/repository.dart';
import 'package:delala/features/products/data/services/products.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';
import 'package:delala/features/products/domain/usecases/GetProductUseCase.dart';
import 'package:delala/features/products/presentation/bloc/products_bloc.dart';
import 'package:delala/features/todo/data/repo/todo_repo_impl.dart';
import 'package:delala/features/todo/data/service/todo_service.dart';
import 'package:delala/features/todo/domain/repository/todo_repo.dart';
import 'package:delala/features/todo/domain/use_case/todo_use.dart';
import 'package:delala/features/todo/presentation/todo_bloc/todo_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
  // Reset GetIt only in development for hot reload; remove in production
  if (const bool.fromEnvironment('dart.vm.product') == false) {
    await sl.reset();
  }

  // Core services
  try {
    sl.registerSingleton<DioClient>(DioClient());
  } catch (e) {
    debugPrint('Failed to register DioClient: $e');
    rethrow;
  }

  // Todo feature
  sl.registerLazySingleton<TodoService>(() => TodoService());
  sl.registerLazySingleton<TodoRepo>(() => TodoRepoImpl(sl()));
  sl.registerLazySingleton<TodoUse>(() => TodoUse(sl()));
  sl.registerFactory<TodoBloc>(() => TodoBloc(sl()));

  // Auth feature (Sign Up)
  sl.registerLazySingleton<AuthService>(() => AuthService(sl<DioClient>()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl()));

  // Auth feature (Sign In)
  sl.registerLazySingleton<SignInService>(() => SignInService(sl<DioClient>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<SignIn>(() => SignIn(sl()));
  sl.registerFactory<SignInBloc>(() => SignInBloc(sl()));

  // Category feature
  sl.registerLazySingleton<CategoryService>(() => CategoryService());
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(categoryService: sl<CategoryService>()),
  );
  // Category use cases
  sl.registerLazySingleton<category_usecases.GetCategoriesUseCase>(
    () => category_usecases.GetCategoriesUseCase(sl()),
  );
  sl.registerLazySingleton<category_usecases.GetSubcategoriesUseCase>(
    () => category_usecases.GetSubcategoriesUseCase(sl()),
  );
  sl.registerLazySingleton<category_usecases.GetCategoryByIdUseCase>(
    () => category_usecases.GetCategoryByIdUseCase(sl()),
  );
  sl.registerLazySingleton<category_usecases.GetSubcategoryByIdUseCase>(
    () => category_usecases.GetSubcategoryByIdUseCase(sl()),
  );

  // Category BLoC
  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategoriesUseCase: sl<category_usecases.GetCategoriesUseCase>(),
      getSubcategoriesUseCase: sl<category_usecases.GetSubcategoriesUseCase>(),
      getCategoryByIdUseCase: sl<category_usecases.GetCategoryByIdUseCase>(),
      getSubcategoryByIdUseCase:
          sl<category_usecases.GetSubcategoryByIdUseCase>(),
    ),
  );

  // Home feature
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<home_usecases.GetProductsUseCase>(
    () => home_usecases.GetProductsUseCase(sl()),
  );
  sl.registerLazySingleton<home_usecases.GetCategoriesUseCase>(
    () => home_usecases.GetCategoriesUseCase(sl()),
  );
  sl.registerLazySingleton<home_usecases.GetUserUseCase>(
    () => home_usecases.GetUserUseCase(sl()),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl<home_usecases.GetProductsUseCase>(),
      sl<home_usecases.GetCategoriesUseCase>(),
      sl<home_usecases.GetUserUseCase>(),
    ),
  );

  // Products feature
  sl.registerLazySingleton<ProductService>(
      () => ProductService(dio: sl<DioClient>().dio));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productService: sl<ProductService>()));
  sl.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(productRepository: sl<ProductRepository>()));
  sl.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(productRepository: sl<ProductRepository>()));

// Register Bloc
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      productRepository: sl<ProductRepository>(),
    ),
  );
}
