import 'package:bloc_api_req_two/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final postBloc = PostsBloc();

  @override
  void initState() {
    // TODO: implement initState
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Page'),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {
          // TODO: implement listener
          switch (state.runtimeType) {
            case PostAddSnackBarActionState:
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Success')));
            case PostAddErrorState:
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error')));
            case PostAddLoadingState:
              showDialog(context: context, builder:(context) {
                return const AlertDialog(
                  title: Text("Loading..."),
                );
              },);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostSuccessful:
              final successState = state as PostSuccessful;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text(
                            successState.postmodelData[index].id!.toString()),
                        Text(successState.postmodelData[index].userId!
                            .toString()),
                        Text(successState.postmodelData[index].title!),
                        Text(successState.postmodelData[index].body!),
                        ElevatedButton(onPressed: () {
                          postBloc.add(PostAddDataEvent(userId: "1",
                              title: "Edwin Baby",
                              body: 'I am Good'));
                        }, child: Text('Post'),),
                      ],
                    ),
                  );
                },
                itemCount: successState.postmodelData.length,
              );
            case PostLoadingState :
              return const Center(child: CircularProgressIndicator());
            case PostErrorState:
              return Center(child: Text('Error'));
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
