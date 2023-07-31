import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../utility/api_exeption.dart';
import '../datasource/product_detail_datasource.dart';
import '/data/model/variant_type.dart';
import '/data/model/product_image.dart';
import '/data/model/category.dart';
import '/data/model/product_variant.dart';
import '/data/model/properties.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, List<ProductImage>>> getProductImages(String productId);
  Future<Either<String, Category>> getProductCategory(String categoryId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<Properties>>> getProductProperties(String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImages(
      String productId) async {
    try {
      var response = await _datasource.getProductImage(productId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var response = await _datasource.getVariantTypes();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      var response = await _datasource.getProductVariants(productId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var response = await _datasource.getProductCategory(categoryId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Properties>>> getProductProperties(String productId) async {
    try {
      var response = await _datasource.getProductProperties(productId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
