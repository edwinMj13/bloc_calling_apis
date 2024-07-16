part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

abstract class PostActionState extends PostsState{}

final class PostsInitial extends PostsState {}

class PostLoadingState extends PostsState {}

class PostErrorState extends PostsState {}

class PostSuccessful extends PostsState{
  final List<PostModelUiData> postmodelData;
  PostSuccessful({required this.postmodelData});
}

class PostAddErrorState extends PostActionState {

}

class PostAddLoadingState extends PostActionState {}

class PostAddSnackBarActionState extends PostActionState{
}



