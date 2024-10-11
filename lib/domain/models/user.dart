class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String avatar;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'avatar': avatar,
    };
  }
}
