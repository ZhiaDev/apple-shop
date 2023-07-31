class Variant {
  String? id;
  String? name;
  String? value;
  String? typeId;
  int? priceChange;

  Variant({
    required this.id,
    required this.name,
    required this.value,
    required this.typeId,
    required this.priceChange,
  });

  factory Variant.fromMapJson(Map<String, dynamic> jsonObject) {
    return Variant(
      id: jsonObject['id'],
      name: jsonObject['name'],
      value: jsonObject['value'],
      typeId: jsonObject['type_id'],
      priceChange: jsonObject['price_change'],
    );
  }
}
