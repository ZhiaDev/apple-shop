part of 'comment_bloc.dart';

abstract class CommentState {}

final class CommentLoading extends CommentState {}

final class CommentResponse extends CommentState {
  final Either<String, List<Comment>> response;

  CommentResponse({required this.response});
}

final class CommentPostLoading extends CommentState {
  final bool isLoading;
  CommentPostLoading({required this.isLoading});
}

final class CommentPostResponse extends CommentState {
  final Either<String, String> response;
  CommentPostResponse({required this.response});
}
