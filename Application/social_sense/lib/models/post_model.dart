import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  List<Post> posts;

  PostModel({
    required this.posts,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<Post> posts = [];
    if (json['posts'] != null) {
      if (json['posts'] is List) {
        posts = List<Post>.from(
            json['posts'].map<Post>((postData) => Post.fromJson(postData)));
      } else {}
    }
    return PostModel(posts: posts);
  }

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  String id;
  User user;
  List<Comment> comments;
  String caption;
  List<String> media;
  DateTime createdAt;
  int totalLikes;
  int totalComments;

  Post({
    required this.id,
    required this.user,
    required this.comments,
    required this.caption,
    required this.media,
    required this.createdAt,
    required this.totalLikes,
    required this.totalComments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["_id"],
      user: User.fromJson(json["user"]),
      comments: json["comments"] == null
          ? []
          : List<Comment>.from(
              json["comments"].map((x) => Comment.fromJson(x))),
      caption: json["caption"],
      media: json["media"] == null
          ? []
          : List<String>.from(json["media"].map((x) => x)),
      createdAt: DateTime.parse(json["createdAt"]),
      totalLikes: json["totalLikes"] ?? 0,
      totalComments: json["totalComments"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "caption": caption,
        "media": List<dynamic>.from(media.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "totalLikes": totalLikes,
        "totalComments": totalComments,
      };
}

class Comment {
  String id;
  User user;
  String text;
  DateTime createdAt;

  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "text": text,
        "createdAt": createdAt.toIso8601String(),
      };
}

class User {
  String id;
  String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
