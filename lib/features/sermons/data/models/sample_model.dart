// ignore_for_file: public_member_api_docs, sort_ructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/core/data/models/color_model.dart';

part 'sample_model.g.dart';

@HiveType(typeId: 2)
class SampleModel extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subTitle;
  @HiveField(2)
  final String sample;

  final ColorModel? color;

  const SampleModel({
    required this.title,
    required this.sample,
    required this.subTitle,
     this.color,
  });

  SampleModel copyWith({
    String? title,
    String? sample,
    String? subTitle,
    ColorModel? color,
  }) {
    return SampleModel(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      sample: sample ?? this.sample,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'sample': sample,
      'subTitle': subTitle,
      'color': color,
    };
  }

  factory SampleModel.fromMap(Map<String, dynamic> map) {
    return SampleModel(
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      sample: map['sample'] as String,
      color: generateColor,
    );
  }

  String toJson() => json.encode(toMap());

  factory SampleModel.fromJson(String source) =>
      SampleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [title, sample, subTitle, color];

  static List<SampleModel> sampleMock = [
    SampleModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
    ),
    SampleModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
    ),
    SampleModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
    ),
    SampleModel(
      title: 'The Power of Faith',
      subTitle: 'This is a sermon sample sub title for testing purpose',
      sample: AppString.htmlSermon,
      color: generateColor,
    ),
  ];
}
