class ProductImage {
  String? imageUrl;
  String? productId;

  ProductImage({required this.imageUrl, required this.productId});

  factory ProductImage.fromMapJson(Map<String, dynamic> jsonObject) {
    return ProductImage(
      imageUrl: 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      productId: jsonObject['product_id'],
    );
  }
}
