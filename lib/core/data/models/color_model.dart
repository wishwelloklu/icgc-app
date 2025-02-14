import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'color_model.g.dart';

@HiveType(typeId: 3)
class ColorModel extends Equatable {
  @HiveField(0)
  final double alpha;
  @HiveField(1)
  final double red;
  @HiveField(2)
  final double green;
  @HiveField(3)
  final double blue;
  const ColorModel({
    required this.alpha,
    required this.red,
    required this.green,
    required this.blue,
  });

  ColorModel copyWith({
    double? alpha,
    double? red,
    double? green,
    double? blue,
  }) {
    return ColorModel(
      alpha: alpha ?? this.alpha,
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'alpha': alpha,
      'red': red,
      'green': green,
      'blue': blue,
    };
  }

  factory ColorModel.fromMap(Map<dynamic, dynamic> map) {
    return ColorModel(
      alpha: map['alpha'].toDouble(),
      red: map['red'].toDouble(),
      green: map['green'].toDouble(),
      blue: map['blue'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [alpha, red, green, blue];

  Color get color => Color.from(
        alpha: alpha,
        red: red,
        green: green,
        blue: blue,
      );
}
