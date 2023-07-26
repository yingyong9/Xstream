import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String uid;
  final String urlAvatar;
  final String phone;
  final String? phoneContact;
  final String? linkLine;
  final String? linkMessaging;
  UserModel({
    required this.name,
    required this.uid,
    required this.urlAvatar,
    required this.phone,
    this.phoneContact,
    this.linkLine,
    this.linkMessaging,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'urlAvatar': urlAvatar,
      'phone': phone,
      'phoneContact': phoneContact,
      'linkLine': linkLine,
      'linkMessaging': linkMessaging,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map['name'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      urlAvatar: (map['urlAvatar'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      phoneContact: map['phoneContact'] ?? '',
      linkLine: map['linkLine'] ?? '',
      linkMessaging: map['linkMessaging']  ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
