// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tag.g.dart';

@HiveType(typeId: 4)
class Tag extends Equatable {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? place;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime? date;
  @HiveField(4)
  final String? time;
  const Tag({
    this.name,
    this.place,
    this.description,
    this.date,
    this.time,
  });

  Tag copyWith({
    String? name,
    String? place,
    String? description,
    DateTime? date,
    String? time,
  }) {
    return Tag(
      name: name ?? this.name,
      place: place ?? this.place,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'place': place,
      'description': description,
      'date': date?.toIso8601String(),
      'time': time?.toString(),
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      name: map['name'] != null ? map['name'] as String : null,
      place: map['place'] != null ? map['place'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      time: map['time'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) =>
      Tag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      place,
      description,
      date,
      time,
    ];
  }

  static TimeOfDay stringToTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
