// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, sort_ructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/core/data/models/color_model.dart';

import 'tag.dart';

part 'sermon_model.g.dart';

@HiveType(typeId: 2)
class SermonModel extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subTitle;
  @HiveField(2)
  final String sample;
  @HiveField(3)
  final ColorModel? color;
  @HiveField(4)
  final List<Tag>? tags;
  @HiveField(5)
  final String? id;
  const SermonModel({
    required this.title,
    required this.subTitle,
    required this.tags,
    required this.sample,
    this.id,
    this.color,
  });

  SermonModel copyWith({
    String? title,
    String? subTitle,
    String? sample,
    String? id,
    ColorModel? color,
    List<Tag>? tags,
  }) {
    return SermonModel(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      sample: sample ?? this.sample,
      color: color ?? this.color,
      id: id ?? this.id,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subTitle': subTitle,
      'sample': sample,
      'id': id,
      'color': color?.toMap(),
      'tags': tags?.map((x) => x.toMap()).toList(),
    };
  }

  factory SermonModel.fromMap(Map<String, dynamic> map) {
    return SermonModel(
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      sample: map['sample'] as String,
      id: map['id'] as String?,
      color: map['color'] != null
          ? ColorModel.fromMap(map['color'] as Map<String, dynamic>)
          : null,
      tags: map['tags'] != null
          ? List<Tag>.from(
              (map['tags'] as List<int>).map<Tag?>(
                (x) => Tag.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SermonModel.fromJson(String source) =>
      SermonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        title,
        sample,
        subTitle,
        color,
        tags,
        id,
      ];

  static List<SermonModel> sampleMock = [
    SermonModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
      tags: const [],
    ),
    SermonModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
      tags: const [],
    ),
    SermonModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
      tags: const [],
    ),
    SermonModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
      tags: const [],
    ),
  ];
}
