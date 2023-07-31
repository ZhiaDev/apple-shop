import 'package:flutter_bloc/flutter_bloc.dart';

import '/di/di.dart';
import '/bloc/product/product_state.dart';
import '/bloc/product/product_event.dart';
import '/data/repository/product_detail_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailProductRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductLoadingState());
      var imageResponse = await _detailProductRepository.getProductImages(
        event.productId,
      );
      var productVariantResponse =
          await _detailProductRepository.getProductVariants(event.productId);
      var productCategoryResponse =
          await _detailProductRepository.getProductCategory(event.categoryId);
      var productPropertiesResponse =
          await _detailProductRepository.getProductProperties(event.productId);

      emit(ProductResponseState(imageResponse, productVariantResponse,
          productCategoryResponse, productPropertiesResponse));
    });
  }
}
