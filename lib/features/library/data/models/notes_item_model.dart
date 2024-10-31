// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:equatable/equatable.dart';
part 'notes_item_model.g.dart';
@HiveType(typeId: 0)
class NotesItemModel extends Equatable {
   @HiveField(0)
  final String title;
   @HiveField(1)
  final String note;
   @HiveField(2)
  final DateTime dateTime;
   @HiveField(3)
  final String? id;
  const NotesItemModel(
      {required this.title,
      required this.note,
      required this.dateTime,
      this.id});

  NotesItemModel copyWith({
    String? title,
    String? note,
    DateTime? dateTime,
  }) {
    return NotesItemModel(
      title: title ?? this.title,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'note': note,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'id': id,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory NotesItemModel.fromMap(Map<String, dynamic> map) {
    return NotesItemModel(
      title: map['title'] as String,
      note: map['note'] as String,
      id: map['note'] as String?,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesItemModel.fromJson(String source) =>
      NotesItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [title, note, dateTime, id];
}
