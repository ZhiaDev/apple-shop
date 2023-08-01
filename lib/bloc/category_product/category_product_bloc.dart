import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import '/bloc/category_product/category_product_event.dart';
import '/bloc/category_product/category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();

  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CategoryProductInitializeEvent>((event, emit) async {
      var response = await _repository.getProductsByCategoryId(
        event.categoryId,
      );
      emit(CategoryProductResponseSuccessState(response));
    });
  }
}
