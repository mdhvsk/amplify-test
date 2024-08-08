class PostCardModel {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String createdAt;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final int likeCount;
  final bool isLiked;

  PostCardModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.likeCount,
      required this.isLiked});

  factory PostCardModel.fromJson(Map<String, dynamic> json) {
    return PostCardModel(
        id: json['id'],
        userId: json['user_id'],
        imageUrl: json['image_url'],
        content: json['content'],
        title: json['title'],
        createdAt: json['created_at'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        likeCount: json['like_count'],
        isLiked: json['is_liked']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'image_url': imageUrl,
      'content': content,
      'title': title,
      'created_at': createdAt,
      'first_name': firstName,
      'last_name': lastName,
      'like_count': likeCount,
      'is_liked': isLiked

    };
  }
}
