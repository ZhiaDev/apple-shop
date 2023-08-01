import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '/data/model/product.dart';
import '../../utility/api_exeption.dart';
import '/data/datasource/category_product_datasource.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(String categoryId) async {
    try {
      var response = await _datasource.getProductsByCategoryId(categoryId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
