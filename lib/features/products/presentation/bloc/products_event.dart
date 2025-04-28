abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String productId;

  FetchProductEvent(this.productId);
}

class FetchProducts extends ProductEvent {
  final String categoryId;

  FetchProducts(this.categoryId);
}

class ResetProductStateEvent extends ProductEvent {} // New event
