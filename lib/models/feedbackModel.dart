class FeedbackModel {
  String? username;
  String? userImage;
  final String productId;
  final String feedback;
  final DateTime timestamp;

  FeedbackModel({
    this.username,
    this.userImage,
    required this.productId,
    required this.feedback,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'userImage': userImage,
      'productId': productId,
      'feedback': feedback,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      // userId: json['userId'],
      productId: json['productId'],
      username: json['username'],
      userImage: json['userImage'],
      feedback: json['feedback'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
