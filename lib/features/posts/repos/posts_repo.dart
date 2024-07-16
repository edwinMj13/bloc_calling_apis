import 'dart:convert';

import 'package:bloc_api_req_two/features/posts/models/post_model_ui_data.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostModelUiData>> getPostData() async {
    var client = http.Client();
    List<PostModelUiData> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List<dynamic> json = jsonDecode(response.body);
      posts = json.map((value) => PostModelUiData.fromJson(value)).toList();
      print(posts);
    } catch (e) {
      print("postInitialFetchEvent Exception $e");
    }
    return posts;
  }

  static Future<bool> addPost(
      {required String title, required String userId, required String body}) async {
    var client = http.Client();
    try {
      final response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": title,
        "body": body,
        "userId": userId,
      });
      print(response.body);
      if(response.statusCode>=200 && response.statusCode<300){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print("AddPost$e");
      return false;
    }
  }
}
