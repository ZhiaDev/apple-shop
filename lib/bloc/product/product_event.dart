abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;

  ProductInitializeEvent({
    required this.productId,
    required this.categoryId,
  });
}
