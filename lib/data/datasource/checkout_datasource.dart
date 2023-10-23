import 'package:hive/hive.dart';
import '/data/model/checkout_item.dart';

abstract class ICheckoutDataSource {
  Future<void> addProduct(CheckoutItem checkoutItem);
  Future<List<CheckoutItem>> getAllCheckoutItems();
  Future<int> getFinalPrice();
  Future<void> removeProduct(int index);
}

class CheckoutLocalDataSource extends ICheckoutDataSource {
  var box = Hive.box<CheckoutItem>('CheckoutItemBox');

  @override
  Future<void> addProduct(CheckoutItem checkoutItem) async {
    box.add(checkoutItem);
  }

  @override
  Future<List<CheckoutItem>> getAllCheckoutItems() async {
    return box.values.toList();
  }

  @override
  Future<int> getFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (previousValue, element) => previousValue + element.discountPrice!);

    return finalPrice;
  }

  @override
  Future<void> removeProduct(int index) async {
    box.deleteAt(index);
  }
}
