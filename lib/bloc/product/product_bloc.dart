import 'package:flutter_bloc/flutter_bloc.dart';

import '/di/di.dart';
import '/bloc/product/product_state.dart';
import '/bloc/product/product_event.dart';
import '/data/repository/product_detail_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailProductRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      var response = await _detailProductRepository.getProductImages();
      emit(ProductResponseState(response));
    });
  }
}
