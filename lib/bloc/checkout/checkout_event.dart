abstract class CheckoutEvent {}

class FetchCheckoutItemListEvent extends CheckoutEvent {}

class CheckoutPaymentInitEvent extends CheckoutEvent {}

class CheckoutPaymentRequestEvent extends CheckoutEvent {}

class CheckoutRemoveProductEvent extends CheckoutEvent {
  int index;
  CheckoutRemoveProductEvent({required this.index});
}
