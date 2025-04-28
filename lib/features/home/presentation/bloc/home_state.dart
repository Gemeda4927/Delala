// States
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final List<UserEntity> users;

  const HomeLoaded({
    required this.products,
    required this.categories,
    required this.users,
  });

  @override
  List<Object> get props => [products, categories, users];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
