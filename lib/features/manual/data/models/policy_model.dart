// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'policy_page.dart';

class PolicyModel extends Equatable {
  final int totalPage;
  final String title;
  final String coverImageUrl;
  final List<PolicyPage> pages;
  const PolicyModel({
    required this.totalPage,
    required this.title,
    required this.coverImageUrl,
    required this.pages,
  });

  PolicyModel copyWith({
    int? totalPage,
    String? title,
    String? coverImageUrl,
    List<PolicyPage>? pages,
  }) {
    return PolicyModel(
      totalPage: totalPage ?? this.totalPage,
      title: title ?? this.title,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      pages: pages ?? this.pages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalPage': totalPage,
      'title': title,
      'coverImageUrl': coverImageUrl,
      'pages': pages.map((x) => x.toMap()).toList(),
    };
  }

  factory PolicyModel.fromMap(Map<String, dynamic> map) {
    return PolicyModel(
      totalPage: map['totalPage'] as int,
      title: map['title'] as String,
      coverImageUrl: map['coverImageUrl'] as String,
      pages: List<PolicyPage>.from(
        (map['pages'].map((e) => PolicyPage.fromMap(e)).toList()),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyModel.fromJson(String source) =>
      PolicyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [totalPage, title, coverImageUrl, pages];
}
