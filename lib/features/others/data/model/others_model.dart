// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:icgc/app/theme/app_images.dart';

class OthersModel extends Equatable {
  final String title;
  final String content;
  final String imageUrl;
  const OthersModel({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  OthersModel copyWith({
    String? title,
    String? content,
    String? imageUrl,
  }) {
    return OthersModel(
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
    };
  }

  factory OthersModel.fromMap(Map<String, dynamic> map) {
    return OthersModel(
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OthersModel.fromJson(String source) =>
      OthersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, content, imageUrl];

  static List<OthersModel> mockData = [
    const OthersModel(
      imageUrl: AppImages.creed,
      title: 'Christian Creed',
      content: """
      I BELIEVE IN GOD, THE FATHER ALMIGHTY,CREATOR OF HEAVEN AND EARTH
      I BELIEVE IN JESUS CHRIST, HIS ONLY SON, OUR LORD,WHO WAS CONCEIVED BY THE HOLY SPIRIT AND BORN OF THE VIRGIN MARY.
      HE SUFFERED UNDER PONTIUS PILATE, WAS CRUCIFIED, DIED, AND WAS BURIED;HE DESCENDED TO HELL.
      THE THIRD DAY HE ROSE AGAIN FROM THE DEAD.HE ASCENDED TO HEAVEN
      AND IS SEATED AT THE RIGHT HAND OF GOD THE FATHER ALMIGHTY. FROM THERE HE WILL COME TO JUDGE THE LIVING AND THE DEAD.
      I BELIEVE IN THE HOLY SPIRIT, THE HOLY CHRISTIAN CHURCH,
      THE COMMUNION OF SAINTS, THE FORGIVENESS OF SINS,
      """,
    )
  ];
}
