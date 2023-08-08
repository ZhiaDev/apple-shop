import 'package:apple_shop/bloc/checkout/checkout_event.dart';
import 'package:apple_shop/bloc/checkout/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/checkout_repository.dart';
import '../../di/di.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final ICheckoutRepository _checkoutRepository = locator.get();

  CheckoutBloc() : super(CheckoutInitState()) {
    on<FetchCheckoutItemListEvent>((event, emit) async {
      var checkoutItemList = await _checkoutRepository.getAllCheckoutItems();
      var finalPrice = await _checkoutRepository.getFinalPrice();

      emit(CheckoutDataFetchedState(checkoutItemList, finalPrice));
    });
  }
}
