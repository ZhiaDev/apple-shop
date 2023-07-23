import 'package:dartz/dartz.dart';

import '/data/model/banner.dart';
import '/data/model/category.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<CampaignBanner>> bannerList;
  Either<String, List<Category>> categoryList;

  HomeRequestSuccessState(this.bannerList, this.categoryList);
}
