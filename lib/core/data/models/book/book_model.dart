// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_images.dart';

import 'package:icgc/core/data/models/book/pages.dart';

class BookModel extends Equatable {
  final UniqueKey id = UniqueKey();
  final String author;
  final int totalPage;
  final int currentPage;
  final String coverImageUrl;
  final String title;
  final List<Pages> pages;
  BookModel({
    required this.author,
    required this.currentPage,
    required this.totalPage,
    required this.coverImageUrl,
    required this.title,
    required this.pages,
  });

  BookModel copyWith({
    String? author,
    int? totalPage,
    String? coverImageUrl,
    String? title,
    int? currentPage,
    List<Pages>? pages,
  }) {
    return BookModel(
      author: author ?? this.author,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      title: title ?? this.title,
      pages: pages ?? this.pages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'totalPage': totalPage,
      'coverImageUrl': coverImageUrl,
      'title': title,
      'pages': pages.map((x) => x.toJson()).toList(),
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      author: map['author'] as String,
      totalPage: int.parse(map['totalPage']),
      coverImageUrl: map['coverImageUrl'] as String,
      title: map['title'] as String,
      currentPage: 2,
      pages: List<Pages>.from((map['pages']).map((e) => Pages.fromJson(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      author,
      totalPage,
      coverImageUrl,
      title,
      pages,
    ];
  }

  static List<BookModel> trendingBookList = [
    BookModel(
        author: 'Wishwell',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageOne,
        title: 'Book title',
        pages: [Pages(pageNumber: 1, content: "")]),
    BookModel(
        author: 'Wishwell',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageTwo,
        title: 'Book title',
        pages: [Pages(pageNumber: 1, content: "")]),
    BookModel(
        author: 'Wishwell',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageOne,
        title: 'Book title',
        pages: [Pages(pageNumber: 1, content: "")]),
    BookModel(
        author: 'Wishwell',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageTwo,
        title: 'Book title',
        pages: [Pages(pageNumber: 1, content: "")]),
  ];
}
