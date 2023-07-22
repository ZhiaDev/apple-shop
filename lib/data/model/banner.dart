class Banner {
  String? id;
  String? collectionId;
  String? categoryId;
  String? thumbnail;

  Banner({
    required this.id,
    required this.collectionId,
    required this.categoryId,
    required this.thumbnail,
  });

  factory Banner.fromMapJson(Map<String, dynamic> jsonObject) {
    return Banner(
      id: jsonObject['id'],
      collectionId: jsonObject['collectionId'],
      categoryId: jsonObject['categoryId'],
      thumbnail:
          'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
