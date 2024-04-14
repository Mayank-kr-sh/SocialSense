class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Post {
  final String id;
  final User user;
  final String caption;
  final List<String> media;

  Post(
      {required this.id,
      required this.user,
      required this.caption,
      required this.media});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      user: User.fromJson(json['user']),
      caption: json['caption'],
      media: List<String>.from(json['media']),
    );
  }
}

class CommentModel {
  final String id;
  final Post? post;
  final User user;
  final String text;
  final String createdAt;

  CommentModel(
      {required this.id,
      this.post,
      required this.user,
      required this.text,
      required this.createdAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      post: json['post'] != null ? Post.fromJson(json['post']) : null,
      user: User.fromJson(json['user']),
      text: json['text'],
      createdAt: json['createdAt'],
    );
  }
}

class CommentsResponse {
  final bool success;
  final List<CommentModel> comments;

  CommentsResponse({required this.success, required this.comments});

  factory CommentsResponse.fromJson(Map<String, dynamic> json) {
    return CommentsResponse(
      success: json['success'],
      comments: List<CommentModel>.from(
          json['comments'].map((x) => CommentModel.fromJson(x))),
    );
  }
}
