// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'naming_ceremoney_variable.g.dart';

@HiveType(typeId: 1)
class NamingCeremoneyVariable extends Equatable {
  @HiveField(0)
  final String child;
  @HiveField(1)
  final String father;
  @HiveField(2)
  final String? mother;
  @HiveField(3)
  final bool isCompleted;

  const NamingCeremoneyVariable(
      {this.mother,
      required this.child,
      required this.father,
      required this.isCompleted});

  @override
  List<Object?> get props => [child, father, mother, isCompleted];

  NamingCeremoneyVariable copyWith({
    String? child,
    String? father,
    String? mother,
    bool? isCompleted,
  }) {
    return NamingCeremoneyVariable(
      child:child ?? this.child,
      father:father ?? this.father,
      mother:mother ?? this.mother,
      isCompleted:isCompleted ?? this.isCompleted,
    );
  }
}
