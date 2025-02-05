class User {
  final String? token;
  final String? name;
  final String? email;

  User({this.token, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'] as String?,
      name: json['user']?['name'] as String?,
      email: json['user']?['email'] as String?,
    );
  }
}
