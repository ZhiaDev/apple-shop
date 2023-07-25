import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../utility/api_exeption.dart';
import '../datasource/product_detail_datasource.dart';
import '/data/model/product_image.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductImages();
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImages() async {
    try {
      var response = await _datasource.getProductImage();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
