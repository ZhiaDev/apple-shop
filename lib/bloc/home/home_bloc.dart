import 'package:bloc/bloc.dart';

import '/di/di.dart';
import 'home_event.dart';
import 'home_state.dart';
import '/data/repository/banner_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetwInitializedData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanners();
      emit(HomeRequestSuccessState(bannerList));
    });
  }
}
