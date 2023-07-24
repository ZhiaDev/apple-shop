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
  });

  factory Product.fromMapJson(Map<String, dynamic> jsonObject) {
    return Product(
      id: jsonObject['id'],
      collectionId: jsonObject['collectionId'],
      thumbnail: 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      description: jsonObject['description'],
      discountPrice: jsonObject['discount_price'],
      price: jsonObject['price'],
      popularity: jsonObject['popularity'],
      name: jsonObject['name'],
      quantity: jsonObject['quantity'],
      category: jsonObject['category'],
    );
  }
}
