import 'dart:convert';

class AuthModel {
  String id, name, phone, email, avatar, token;

  AuthModel({
    this.id = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.avatar = '',
    this.token = '',
  });

  factory AuthModel.fromFirebase(Map<String, dynamic> map) {
    return AuthModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
        'avatar': avatar,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AuthModel(id: $id, name: $name, phone: $phone, email: $email, avatar: $avatar, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
