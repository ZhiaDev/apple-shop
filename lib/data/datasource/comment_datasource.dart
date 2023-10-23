import 'package:dio/dio.dart';

import '../../utility/api_exeption.dart';
import '/di/di.dart';
import '../model/comment.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String text, String productId);
}

class CommentRemoteDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Comment>> getComments(String productId) async {
    Map<String, String> qParams = {
      'filter': 'product_id="$productId"',
      'expand': 'user_id'
    };

    try {
      var response = await _dio.get(
        'collections/comment/records',
        queryParameters: qParams,
      );
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }

  @override
  Future<void> postComment(String text, String productId) async {
    try {
      await _dio.post(
        'collections/comment/records',
        data: {
          'text': text,
          'user_id': 'lkg8xc50i07oedn',
          'product_id': productId,
        },
      );
    } on DioException catch (e) {
      throw ApiExeption(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
