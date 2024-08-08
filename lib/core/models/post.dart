class PostModel {

  final int id;
  final int user_id;
  final String? image_id;
  final String content;
  final String title;
  final DateTime created_at;


  PostModel({required this.id, required this.user_id, this.image_id, required this.content, required this.title, required this.created_at});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      user_id: json['user_id'],
      image_id: json['image_id'],
      content: json['content'],
      title: json['title'],
      created_at: DateTime.parse(json['created_at']),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'image_id': image_id,
      'content': content,
      'title': title,
      'created_at': created_at
    };
  }
}