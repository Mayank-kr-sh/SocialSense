class NotificationModel {
  final String postId;
  final String userId;
  final String comment;
  final String userName;
  final String url;

  NotificationModel({
    required this.postId,
    required this.userId,
    required this.comment,
    required this.userName,
    required this.url,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print('NotificationModel.fromJson: $json');
    return NotificationModel(
      postId: json['postId'],
      userId: json['userId'],
      comment: json['comment'],
      userName: json['userName'],
      url: json['url'],
    );
  }
}
