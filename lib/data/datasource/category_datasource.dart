import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../utility/api_exeption.dart';
import '../model/category.dart';

abstract class ICategoryDataSource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _dio.get('collections/category/records');

      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
