part of 'comment_bloc.dart';

abstract class CommentEvent {}

class CommentInitializeEvent extends CommentEvent {
  String productId;
  CommentInitializeEvent({required this.productId});
}

class CommentPostEvent extends CommentEvent {
  String text;
  String productId;
  CommentPostEvent({required this.text, required this.productId});
}
