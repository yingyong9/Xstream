import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String uid;
  final String urlAvatar;
  final String phone;
  UserModel({
    required this.name,
    required this.uid,
    required this.urlAvatar,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'urlAvatar': urlAvatar,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map['name'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      urlAvatar: (map['urlAvatar'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
