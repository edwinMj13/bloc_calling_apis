import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_req_two/features/posts/models/post_model_ui_data.dart';
import 'package:bloc_api_req_two/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

import '../models/post_model_ui_data.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddDataEvent>(postAddDataEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostsState> emit) async {
    List<PostModelUiData> posts = await PostsRepo.getPostData();
    emit(PostSuccessful(postmodelData: posts));
  }

  Future<FutureOr<void>> postAddDataEvent(
      PostAddDataEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost(
      title: event.title,
      userId: event.userId,
      body: event.body,
    );
    if(success==true){
      emit( PostAddSnackBarActionState());
    }else if(success==false){
      emit(PostAddErrorState());
    }else{
      emit(PostLoadingState());
    }

    print(success);

  }
}
