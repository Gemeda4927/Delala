import 'package:delala/features/home/domain/usecases/get_home_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetUserUseCase _getUserUseCase;

  HomeBloc(
    this._getProductsUseCase,
    this._getCategoriesUseCase,
    this._getUserUseCase,
  ) : super(HomeInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<FetchUsersEvent>(_onFetchUsers);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final products = await _getProductsUseCase.execute();
      final currentState = state;

      // Log the number of products fetched
      print('Fetched ${products.length} products');

      // Update state with new products, preserving categories and users
      if (currentState is HomeLoaded) {
        emit(HomeLoaded(
          products: products,
          categories: currentState.categories,
          users: currentState.users,
        ));
      } else {
        emit(HomeLoaded(
          products: products,
          categories: [],
          users: [],
        ));
      }
    } catch (e, stackTrace) {
      // Print detailed error for debugging
      print('Error fetching products: $e');
      print('Stack Trace: $stackTrace');
      emit(const HomeError('Failed to load products'));
    }
  }

  Future<void> _onFetchCategories(
    FetchCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final categories = await _getCategoriesUseCase.execute();
      final currentState = state;

      // Log the number of categories fetched
      print('Fetched ${categories.length} categories');

      // Update state with new categories, preserving products and users
      if (currentState is HomeLoaded) {
        emit(HomeLoaded(
          products: currentState.products,
          categories: categories,
          users: currentState.users,
        ));
      } else {
        emit(HomeLoaded(
          products: [],
          categories: categories,
          users: [],
        ));
      }
    } catch (e, stackTrace) {
      // Print detailed error for debugging
      print('Error fetching categories: $e');
      print('Stack Trace: $stackTrace');
      emit(const HomeError('Failed to load categories'));
    }
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final users = await _getUserUseCase.execute();
      final currentState = state;

      // Log the number of users fetched
      print('Fetched ${users.length} users');

      // Update state with new users, preserving products and categories
      if (currentState is HomeLoaded) {
        emit(HomeLoaded(
          products: currentState.products,
          categories: currentState.categories,
          users: users,
        ));
      } else {
        emit(HomeLoaded(
          products: [],
          categories: [],
          users: users,
        ));
      }
    } catch (e, stackTrace) {
      // Print detailed error for debugging
      print('Error fetching users: $e');
      print('Stack Trace: $stackTrace');
      emit(const HomeError('Failed to load users'));
    }
  }
}
