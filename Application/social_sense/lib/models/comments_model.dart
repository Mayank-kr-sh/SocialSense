class CommentModel {
  final String msg;
  final bool success;
  final CommentData data;

  CommentModel({
    required this.msg,
    required this.success,
    required this.data,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      msg: json['msg'],
      success: json['success'],
      data: CommentData.fromJson(json['data']),
    );
  }
}

class CommentData {
  final String user;
  final String post;
  final String text;
  final String id;
  final String createdAt;
  final int v;

  CommentData({
    required this.user,
    required this.post,
    required this.text,
    required this.id,
    required this.createdAt,
    required this.v,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      user: json['user'],
      post: json['post'],
      text: json['text'],
      id: json['_id'],
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }
}
