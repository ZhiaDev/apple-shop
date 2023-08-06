import 'package:hive/hive.dart';
import '/data/model/checkout_item.dart';

abstract class ICheckoutDataSource {
  Future<void> addProduct(CheckoutItem checkoutItem);
}

class CheckoutLocalDataSource extends ICheckoutDataSource {
  var box = Hive.box<CheckoutItem>('CheckoutItemBox');

  @override
  Future<void> addProduct(CheckoutItem checkoutItem) async {
    box.add(checkoutItem);
  }
}
