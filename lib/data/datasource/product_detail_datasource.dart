import 'package:apple_shop/data/model/category.dart';
import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../utility/api_exeption.dart';
import '../model/properties.dart';
import '../model/variant.dart';
import '../model/variant_type.dart';
import '/data/model/product_image.dart';
import '/data/model/product_variant.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getProductImage(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants(String productId);
  Future<List<ProductVariant>> getProductVariants(String productId);
  Future<Category> getProductCategory(String categoryId);
  Future<List<Properties>> getProductProperties(String productId);
}

class ProductDetailRemoteDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getProductImage(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
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

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');

      return response.data['items']
          .map<VariantType>(
            (jsonObject) => VariantType.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var response = await _dio.get(
        'collections/variants/records',
        queryParameters: qParams,
      );

      return response.data['items']
          .map<Variant>(
            (jsonObject) => Variant.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);

    List<ProductVariant> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var variant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();
        productVariantList.add(
          ProductVariant(variantType: variantType, variantList: variant),
        );
      }
      return productVariantList;
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoryId"'};
      var response = await _dio.get(
        'collections/category/records',
        queryParameters: qParams,
      );
      return Category.fromMapJson(response.data['items'][0]);
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }

  @override
  Future<List<Properties>> getProductProperties(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var response = await _dio.get(
        'collections/properties/records',
        queryParameters: qParams,
      );

      return response.data['items']
          .map<Properties>(
            (jsonObject) => Properties.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
