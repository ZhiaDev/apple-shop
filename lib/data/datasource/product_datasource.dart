import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../model/product.dart';
import '/utility/api_exeption.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDataSource extends IProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response!.statusCode, e.response!.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
