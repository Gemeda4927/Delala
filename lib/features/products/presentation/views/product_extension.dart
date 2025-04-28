import 'package:delala/features/products/data/models/products.dart'
    show Product;

extension ProductExtension on Product {
  double? get discountedPrice {
    if (discount != null && discount! > 0) {
      return price * (1 - discount! / 100);
    }
    return null;
  }
}
