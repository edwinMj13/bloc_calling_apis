import 'dart:convert';
PostModelUiData postModelUiDataFromJson(String str) => PostModelUiData.fromJson(json.decode(str));
String postModelUiDataToJson(PostModelUiData data) => json.encode(data.toJson());
class PostModelUiData {
  PostModelUiData({
      this.userId, 
      this.id, 
      this.title, 
      this.body,});

  PostModelUiData.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  int? userId;
  int? id;
  String? title;
  String? body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    return map;
  }

}