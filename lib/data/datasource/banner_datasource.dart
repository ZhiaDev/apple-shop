import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../utility/api_exeption.dart';
import '../model/banner.dart';

abstract class IBannerDataSource {
  Future<List<Banner>> getBanners();
}

class BannerRemoteDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Banner>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');

      return response.data['items']
          .map<Banner>((jsonObject) => Banner.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
  