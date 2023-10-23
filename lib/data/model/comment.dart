class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userAvatarUrl;
  String avatarEmptyChecker;
  String userName;

  Comment({
    required this.id,
    required this.text,
    required this.productId,
    required this.userId,
    required this.userAvatarUrl,
    required this.avatarEmptyChecker,
    required this.userName,
  });

  factory Comment.fromMapJson(Map<String, dynamic> jsonObject) {
    return Comment(
      id: jsonObject['id'],
      text: jsonObject['text'],
      productId: jsonObject['product_id'],
      userId: jsonObject['user_id'],
      userAvatarUrl: 'http://startflutter.ir/api/files/${jsonObject['expand']['user_id']['collectionId']}/${jsonObject['expand']['user_id']['id']}/${jsonObject['expand']['user_id']['avatar']}',
      avatarEmptyChecker: jsonObject['expand']['user_id']['avatar'],
      userName: jsonObject['expand']['user_id']['name'],
    );
  }
}