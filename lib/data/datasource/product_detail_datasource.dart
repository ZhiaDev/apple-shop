import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../utility/api_exeption.dart';
import '/data/model/product_image.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getProductImage();
}

class ProductDetailRemoteDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getProductImage() async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="Hotest"'};
      var response = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParams,
      );

      return response.data['items']
          .map<ProductImage>(
            (jsonObject) => ProductImage.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
