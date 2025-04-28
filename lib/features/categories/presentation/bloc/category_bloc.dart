// Category BLoC
import 'package:chapasdk/features/network/bloc/network_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:delala/core/error/failures.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/domain/usecases/category_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSubcategoriesUseCase getSubcategoriesUseCase;
  final GetCategoryByIdUseCase getCategoryByIdUseCase;
  final GetSubcategoryByIdUseCase getSubcategoryByIdUseCase;

  CategoryBloc({
    required this.getCategoriesUseCase,
    required this.getSubcategoriesUseCase,
    required this.getCategoryByIdUseCase,
    required this.getSubcategoryByIdUseCase,
  }) : super(CategoryInitial()) {
    on<FetchCategories>(_onFetchCategories);
    on<FetchSubcategories>(_onFetchSubcategories);
    on<FetchCategoryById>(_onFetchCategoryById);
    on<FetchSubcategoryById>(_onFetchSubcategoryById);
  }

  Future<void> _onFetchCategories(
    FetchCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final either = await getCategoriesUseCase();
    emit(_handleEitherCategories(either));
  }

  Future<void> _onFetchSubcategories(
    FetchSubcategories event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is SubcategoriesLoaded) {
      final currentSubcategories = (state as SubcategoriesLoaded).subcategories;
      if (currentSubcategories.any((cat) => cat.parentId == event.categoryId)) {
        return;
      }
    }
    emit(CategoryLoading());
    final either = await getSubcategoriesUseCase(event.categoryId);
    emit(_handleEitherSubcategories(either));
  }

  Future<void> _onFetchCategoryById(
    FetchCategoryById event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final either = await getCategoryByIdUseCase(event.categoryId);
    emit(_handleEitherCategory(either as Either<Failure, CategoryEntity>));
  }

  Future<void> _onFetchSubcategoryById(
    FetchSubcategoryById event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final either = await getSubcategoryByIdUseCase(event.subcategoryId);
    emit(
        _handleEitherSubcategory(either as Either<Failure, SubcategoryEntity>));
  }

  CategoryState _handleEitherCategories(
    Either<Failure, List<CategoryEntity>> either,
  ) {
    return either.fold(
      (failure) => CategoryError(_mapFailureToMessage(failure)),
      (categories) => CategoriesLoaded(categories),
    );
  }

  CategoryState _handleEitherSubcategories(
    Either<Failure, List<SubcategoryEntity>> either,
  ) {
    return either.fold(
      (failure) => CategoryError(_mapFailureToMessage(failure)),
      (subcategories) => SubcategoriesLoaded(subcategories),
    );
  }

  CategoryState _handleEitherCategory(
    Either<Failure, CategoryEntity> either,
  ) {
    return either.fold(
      (failure) => CategoryError(_mapFailureToMessage(failure)),
      (category) => CategoryLoaded(category),
    );
  }

  CategoryState _handleEitherSubcategory(
    Either<Failure, SubcategoryEntity> either,
  ) {
    return either.fold(
      (failure) => CategoryError(_mapFailureToMessage(failure)),
      (subcategory) => SubcategoryLoaded(subcategory),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Unable to load data from server. Please try again later.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network and try again.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }
}
