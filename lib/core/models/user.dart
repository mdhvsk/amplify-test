class UserModel {
  final int id;
  final String username;
  final String firstName;
  final String lastName;

  UserModel({required this.id, required this.username, required this.firstName, required this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName
    };
  }
}