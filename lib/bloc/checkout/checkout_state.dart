import 'package:dartz/dartz.dart';

import '/data/model/checkout_item.dart';

abstract class CheckoutState {}

class CheckoutInitState extends CheckoutState {}

class CheckoutDataFetchedState extends CheckoutState {
  Either<String, List<CheckoutItem>> checkoutItemList;
  int checkoutFinalPrice;

  CheckoutDataFetchedState(this.checkoutItemList, this.checkoutFinalPrice);
}
