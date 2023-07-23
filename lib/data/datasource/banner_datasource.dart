import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../model/banner.dart';
import '../../utility/api_exeption.dart';

abstract class IBannerDataSource {
  Future<List<CampaignBanner>> getBanners();
}

class BannerRemoteDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<CampaignBanner>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');

      return response.data['items']
          .map<CampaignBanner>((jsonObject) => CampaignBanner.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
  