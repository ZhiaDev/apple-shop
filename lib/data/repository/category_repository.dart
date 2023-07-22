import 'package:apple_shop/utility/api_exeption.dart';
import 'package:dartz/dartz.dart';

import '../model/category.dart';
import '/di/di.dart';
import '/data/datasource/category_datasource.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
