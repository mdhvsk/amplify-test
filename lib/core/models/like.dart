
class LikeModel{
  final int id;
  final int userId;
  final int postId;

  LikeModel({required this.id, required this.userId, required this.postId});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      userId: json['user_id'],
      postId: json['post_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'post_id': postId,
    };
  }

}