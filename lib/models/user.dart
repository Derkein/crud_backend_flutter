class User {
  final String id;
  final String username;
  final String passwordHash;

  User({required this.id, required this.username, required this.passwordHash});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      passwordHash: json['passwordHash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'passwordHash': passwordHash};
  }
}