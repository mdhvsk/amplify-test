class LikeCount {
  int count;
  int post_id;

  LikeCount({required this.count, required this.post_id});

  factory LikeCount.fromJson(Map<String, dynamic> json) {
    return LikeCount(
      count: json['count'],
      post_id: json['post_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'post_id': post_id,
    };
  }

  void setCount(int count){
    this.count = count;
  }
}