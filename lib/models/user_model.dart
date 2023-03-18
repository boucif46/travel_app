class User {
  int id;
  String name;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  User({
   required this.id,
   required this.name,
   required this.email,
   required this.createdAt,
   required this.updatedAt,
   required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      createdAt: DateTime.parse(json['user']['created_at']),
      updatedAt: DateTime.parse(json['user']['updated_at']),
      token: json['tokenis'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user': {
          'id': id,
          'name': name,
          'email': email,
          'created_at': createdAt.toIso8601String(),
          'updated_at': updatedAt.toIso8601String(),
        },
        'tokenis': token,
      };
}
