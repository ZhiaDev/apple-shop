class Product {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? description;
  int? discountPrice;
  int? price;
  String? popularity;
  String? name;
  int? quantity;
  String? category;
  num? percent;

  Product({
    required this.id,
    required this.collectionId,
    required this.thumbnail,
    required this.description,
    required this.discountPrice,
    required this.price,
    required this.popularity,
    required this.name,
    required this.quantity,
    required this.category,
  }) {
    percent = ((price! - discountPrice!) / price!) * 100;
  }

  factory Product.fromMapJson(Map<String, dynamic> jsonObject) {
    return Product(
      id: jsonObject['id'],
      name: jsonObject['name'],
      price: jsonObject['price'],
      quantity: jsonObject['quantity'],
      category: jsonObject['category'],
      popularity: jsonObject['popularity'],
      description: jsonObject['description'],
      collectionId: jsonObject['collectionId'],
      discountPrice: jsonObject['price'] + jsonObject['discount_price'],
      thumbnail: 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
