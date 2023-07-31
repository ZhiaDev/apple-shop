class VariantType {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;

  VariantType({
    required this.id,
    required this.type,
    required this.name,
    required this.title,
  });

  factory VariantType.fromMapJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      id: jsonObject['id'],
      name: jsonObject['name'],
      title: jsonObject['title'],
      type: _getTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.color;
    case 'Storage':
      return VariantTypeEnum.storage;
    case 'Voltage':
      return VariantTypeEnum.voltage;
    default:
      return VariantTypeEnum.color;
  }
}

enum VariantTypeEnum { color, storage, voltage }
