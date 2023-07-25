import 'package:apple_shop/data/model/product_image.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> getProductImages;

  ProductResponseState(this.getProductImages);
}
