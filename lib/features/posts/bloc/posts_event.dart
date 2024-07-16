part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostInitialFetchEvent extends PostsEvent{}

class PostAddDataEvent extends PostsEvent {
  final String userId;
  final String title;
  final String body;

  PostAddDataEvent({required this.userId, required this.title, required this.body});


}


