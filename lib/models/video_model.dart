import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String url;
  final String image;
  final String? desc;
  final String? uidOwner;
  final Timestamp? timestamp;
  VideoModel({
    required this.url,
    required this.image,
    this.desc,
    this.uidOwner,
     this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'image': image,
      'desc': desc,
      'uidOwner': uidOwner,
      'timestamp': timestamp,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      url: (map['url'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      desc: map['desc'] != null ? map['desc'] as String : null,
      uidOwner: map['uidOwner'] != null ? map['uidOwner'] as String : null,
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
