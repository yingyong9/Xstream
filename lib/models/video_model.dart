import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String url;
  final String image;
  final String? desc;
  VideoModel({
    required this.url,
    required this.image,
     this.desc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'image': image,
      'desc': desc,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      url: (map['url'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      desc: (map['desc'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
