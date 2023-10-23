import 'package:dartz/dartz.dart';

import '/di/di.dart';
import '../model/comment.dart';
import '/utility/api_exeption.dart';
import '../datasource/comment_datasource.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComment(String text, String productId);
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
  
  @override
  Future<Either<String, String>> postComment(String text, String productId) async {
    try {
      await _datasource.postComment(text, productId);
      return right('نظر شما ثبت شد :)');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
