import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Data data;

  Post({
    required this.data,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String user;
  List<dynamic> comments;
  List<dynamic> likes;
  String caption;
  List<dynamic> media;
  String id;
  DateTime createdAt;

  Data({
    required this.user,
    required this.comments,
    required this.likes,
    required this.caption,
    required this.media,
    required this.id,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        caption: json["caption"],
        media: List<dynamic>.from(json["media"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "caption": caption,
        "media": List<dynamic>.from(media.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
