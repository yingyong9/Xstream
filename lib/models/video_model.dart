import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String url;
  final String image;
  final String? desc;
  final Timestamp timestamp;
  final Map<String, dynamic> mapUserModel;
  final String? detail;
  VideoModel({
    required this.url,
    required this.image,
    this.desc,
    required this.timestamp,
    required this.mapUserModel,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'image': image,
      'desc': desc,
      'timestamp': timestamp,
      'mapUserModel': mapUserModel,
      'detail': detail,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      url: (map['url'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      desc: map['desc'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp(0, 0),
      mapUserModel: Map<String, dynamic>.from(map['mapUserModel'] ?? {}),
      detail: (map['detail'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
