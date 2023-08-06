import 'package:dartz/dartz.dart';

import '/data/datasource/checkout_datasource.dart';
import '../model/checkout_item.dart';
import '/di/di.dart';

abstract class ICheckoutRepository {
  Future<Either<String, String>> addProductToCheckout(
      CheckoutItem checkoutItem);
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
}
