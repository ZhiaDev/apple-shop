import 'package:dio/dio.dart';

import '/data/model/product.dart';
import '../../di/di.dart';
import '../../utility/api_exeption.dart';

abstract class ICategoryProductDataSource {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}

class CategoryProductRemoteDataSource extends ICategoryProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'category="$categoryId"'};
      Response<dynamic> response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get(
          'collections/products/records',
        );
      } else {
        response = await _dio.get(
          'collections/products/records',
          queryParameters: qParams,
        );
      }

      return response.data['items']
          .map<Product>(
            (jsonObject) => Product.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
