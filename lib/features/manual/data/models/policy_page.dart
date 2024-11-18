// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PolicyPage extends Equatable {
  final int pageNumber;
  final String? title;
  final String content;
  const PolicyPage({
    required this.pageNumber,
    required this.title,
    required this.content,
  });

  PolicyPage copyWith({
    int? pageNumber,
    String? title,
    String? content,
  }) {
    return PolicyPage(
      pageNumber: pageNumber ?? this.pageNumber,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page_number': pageNumber,
      'title': title,
      'content': content,
    };
  }

  factory PolicyPage.fromMap(Map<String, dynamic> map) {
    return PolicyPage(
      pageNumber: map['page_number'] as int,
      title: map['title'] as String?,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyPage.fromJson(String source) =>
      PolicyPage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [pageNumber, title, content];
}
