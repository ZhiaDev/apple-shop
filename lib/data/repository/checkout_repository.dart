import 'package:dartz/dartz.dart';

import '/data/datasource/checkout_datasource.dart';
import '../model/checkout_item.dart';
import '/di/di.dart';

abstract class ICheckoutRepository {
  Future<Either<String, String>> addProductToCheckout(
      CheckoutItem checkoutItem);
  Future<Either<String, List<CheckoutItem>>> getAllCheckoutItems();
  Future<int> getFinalPrice();
  Future<void> removeProduct(int index);
}

class CheckoutRepository extends ICheckoutRepository {
  final ICheckoutDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToCheckout(
      CheckoutItem checkoutItem) async {
    try {
      _dataSource.addProduct(checkoutItem);
      return const Right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return const Left('خطا در افزودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<CheckoutItem>>> getAllCheckoutItems() async {
    try {
      var checkoutItemList = await _dataSource.getAllCheckoutItems();
      return right(checkoutItemList);
    } catch (e) {
      return const Left('خطا در نمایش محصولات سبد خرید');
    }
  }

  @override
  Future<int> getFinalPrice() async {
    return _dataSource.getFinalPrice();
  }

  @override
  Future<void> removeProduct(int index) async {
    _dataSource.removeProduct(index);
  }
}
