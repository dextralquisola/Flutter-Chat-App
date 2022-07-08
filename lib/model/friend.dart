import 'dart:convert';

class Friend {
  final String id;
  final String name;
  final String email;
  Friend({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});

    return result;
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Friend.fromJson(String source) => Friend.fromMap(json.decode(source));
}
