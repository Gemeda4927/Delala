import 'package:delala/features/products/data/models/products.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final Product product;

  ProductLoadedState(this.product);
}

class ProductsLoadedState extends ProductState {
  final List<Product> products;

  ProductsLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);
}
