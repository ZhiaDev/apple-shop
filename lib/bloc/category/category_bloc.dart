import 'package:flutter_bloc/flutter_bloc.dart';

import '/di/di.dart';
import '/bloc/category/category_state.dart';
import '/bloc/category/category_event.dart';
import '../../data/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();

  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryRequestList>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}
