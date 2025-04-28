import 'package:bloc/bloc.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';
import 'package:delala/features/products/presentation/bloc/products_event.dart';
import 'package:delala/features/products/presentation/bloc/products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitialState()) {
    on<FetchProductEvent>(_onFetchProduct);
    on<FetchProducts>(_onFetchProducts);
    on<ResetProductStateEvent>(_onResetProductState); // New event handler
  }

  Future<void> _onFetchProduct(
      FetchProductEvent event, Emitter<ProductState> emit) async {
    print('ProductBloc - Handling FetchProductEvent with productId: ${event.productId}');
    emit(ProductLoadingState());
    try {
      final product = await productRepository.getProduct(event.productId);
      emit(ProductLoadedState(product));
    } catch (e) {
      print('ProductBloc - Error fetching product: $e');
      emit(ProductErrorState("Failed to fetch product: ${e.toString()}"));
    }
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    print('ProductBloc - Handling FetchProducts with categoryId: ${event.categoryId}');
    emit(ProductLoadingState());
    try {
      final products = await productRepository.getProducts(event.categoryId);
      print('ProductBloc - Fetched ${products.length} products for category ${event.categoryId}');
      emit(ProductsLoadedState(products));
    } catch (e) {
      print('ProductBloc - Error fetching products: $e');
      emit(ProductErrorState("Failed to fetch products: ${e.toString()}"));
    }
  }

  void _onResetProductState(
      ResetProductStateEvent event, Emitter<ProductState> emit) {
    print('ProductBloc - Resetting state to ProductInitialState');
    emit(ProductInitialState());
  }
}