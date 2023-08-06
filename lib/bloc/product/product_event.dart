import 'package:apple_shop/data/model/product.dart';

abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;

  ProductInitializeEvent({required this.productId, required this.categoryId});
}

class ProductAddToCheckout extends ProductEvent {
  Product product;

  ProductAddToCheckout(this.product);
}
