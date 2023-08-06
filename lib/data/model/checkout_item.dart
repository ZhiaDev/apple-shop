import 'package:hive/hive.dart';

part 'checkout_item.g.dart';

@HiveType(typeId: 0)
class CheckoutItem {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? collectionId;
  @HiveField(2)
  String? thumbnail;
  @HiveField(3)
  int? discountPrice;
  @HiveField(4)
  int? price;
  @HiveField(5)
  String? name;
  @HiveField(6)
  String? category;
  @HiveField(7)
  int? realPrice;
  @HiveField(8)
  num? percent;

  CheckoutItem({
    required this.id,
    required this.collectionId,
    required this.thumbnail,
    required this.discountPrice,
    required this.price,
    required this.name,
    required this.category,
  }) {
    realPrice = (price! + discountPrice!);
    percent = ((price! - discountPrice!) / price!) * 100;
  }
}
