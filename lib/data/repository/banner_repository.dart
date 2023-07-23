import 'package:dartz/dartz.dart';

import '/di/di.dart';
import '../model/banner.dart';
import '/utility/api_exeption.dart';
import '/data/datasource/banner_datasource.dart';

abstract class IBannerRepository {
  Future<Either<String, List<CampaignBanner>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<CampaignBanner>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
