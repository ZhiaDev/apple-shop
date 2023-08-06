import 'package:apple_shop/data/repository/checkout_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/checkout_item.dart';
import '/di/di.dart';
import '/bloc/product/product_state.dart';
import '/bloc/product/product_event.dart';
import '/data/repository/product_detail_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailProductRepository = locator.get();
  final ICheckoutRepository _checkoutRepository = locator.get();

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

    on<ProductAddToCheckout>((event, emit) {
      var item = CheckoutItem(
        id: event.product.id,
        collectionId: event.product.collectionId,
        thumbnail: event.product.thumbnail,
        discountPrice: event.product.discountPrice,
        price: event.product.price,
        name: event.product.name,
        category: event.product.category,
      );

      _checkoutRepository.addProductToCheckout(item);
    });
  }
}
