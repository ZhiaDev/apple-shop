class Category {
  String? collectionId;
  String? id;
  String? thumbnail;
  String? title;
  String? color;
  String? icon;

  Category({
    required this.collectionId,
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.color,
    required this.icon,
  });

  factory Category.fromMapJson(Map<String, dynamic> jsonObject) {
    return Category(
      id: jsonObject['id'],
      title: jsonObject['title'],
      color: jsonObject['color'],
      collectionId: jsonObject['collectionId'],
      icon: 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['icon']}',
      thumbnail: 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
