import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/properties.dart';
import 'package:dartz/dartz.dart';

import '/data/model/product_image.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, Category> productCategory;
  Either<String, List<Properties>> productProperties;

  ProductResponseState(
    this.productImages,
    this.productVariant,
    this.productCategory,
    this.productProperties
  );
}
