import '/data/model/variant.dart';
import '/data/model/variant_type.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;

  ProductVariant({required this.variantType, required this.variantList});

  get typeId => null;
}
