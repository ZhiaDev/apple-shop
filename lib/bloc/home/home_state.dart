import 'package:dartz/dartz.dart';

import '/data/model/banner.dart';
import '/data/model/category.dart';
import '../../data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<CampaignBanner>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hotestProductList;
  Either<String, List<Product>> bestSellerProductList;

  HomeRequestSuccessState(
    this.bannerList,
    this.categoryList,
    this.productList,
    this.hotestProductList,
    this.bestSellerProductList,
  );
}
