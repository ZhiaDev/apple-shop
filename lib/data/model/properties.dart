class Properties {
  String? id;
  String? title;
  String? value;
  String? collectionId;

  Properties({
    required this.id,
    required this.title,
    required this.value,
    required this.collectionId,
  });

  factory Properties.fromMapJson(Map<String, dynamic> jsonObject) {
    return Properties(
      id: jsonObject['id'],
      title: jsonObject['title'],
      value: jsonObject['value'],
      collectionId: jsonObject['collectionId'],
    );
  }
}
