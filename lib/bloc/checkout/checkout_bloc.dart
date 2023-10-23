import 'package:flutter_bloc/flutter_bloc.dart';

import '/utility/payment_handler.dart';
import '/bloc/checkout/checkout_event.dart';
import '/bloc/checkout/checkout_state.dart';
import '../../data/repository/checkout_repository.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final ICheckoutRepository _checkoutRepository;
  final PaymentHandler _paymentHandler;

  CheckoutBloc(this._paymentHandler, this._checkoutRepository)
      : super(CheckoutInitState()) {
    on<FetchCheckoutItemListEvent>((event, emit) async {
      var checkoutItemList = await _checkoutRepository.getAllCheckoutItems();
      var finalPrice = await _checkoutRepository.getFinalPrice();

      emit(CheckoutDataFetchedState(checkoutItemList, finalPrice));
    });

    on<CheckoutPaymentInitEvent>((event, emit) async {
      var finalPrice = await _checkoutRepository.getFinalPrice();
      _paymentHandler.initPaymentRquest(finalPrice);
    });

    on<CheckoutPaymentRequestEvent>((event, emit) async {
      _paymentHandler.sendPaymentRquest();
    });

    on<CheckoutRemoveProductEvent>((event, emit) async {
      _checkoutRepository.removeProduct(event.index);
      var checkoutItemList = await _checkoutRepository.getAllCheckoutItems();
      var finalPrice = await _checkoutRepository.getFinalPrice();

      emit(CheckoutDataFetchedState(checkoutItemList, finalPrice));
    });
  }
}
