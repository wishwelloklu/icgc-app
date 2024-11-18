// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_images.dart';

import 'pages.dart';

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
        author: 'Mensah Otabil',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageOne,
        title:
            'The Rise of Urban Farming: A Solution to Global Food Insecurity?',
        pages: [
          Pages(
              pageNumber: 1,
              content:
                  "Mr. Gregg is most notable for his 1853 appointment by President Franklin Pierce as Commissioner to the Kingdom of Hawaii. In this role he was to negotiate its annexation, which he failed to do. The picture of Mr. Gregg on his Wikipedia entry is a very faded grayish brown, and is either a competent drawing or a bad photograph of a young looking man with small glasses, a receding hairline, and a pleasant not-quite smile on his face. It occurs to me")
        ]),
    BookModel(
        author: 'Mensah Otabil',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageTwo,
        title:
            'Rediscovering Ancient Cultures: Lost Civilizations of South America',
        pages: [
          Pages(
              pageNumber: 1,
              content:
                  "Mr. Gregg is most notable for his 1853 appointment by President Franklin Pierce as Commissioner to the Kingdom of Hawaii. In this role he was to negotiate its annexation, which he failed to do. The picture of Mr. Gregg on his Wikipedia entry is a very faded grayish brown, and is either a competent drawing or a bad photograph of a young looking man with small glasses, a receding hairline, and a pleasant not-quite smile on his face. It occurs to me")
        ]),
    BookModel(
        author: 'Mensah Otabil',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageOne,
        title:
            'Unlocking the Mysteries of the Deep Sea: New Discoveries from the Ocean Floor',
        pages: [
          Pages(
              pageNumber: 1,
              content:
                  "Mr. Gregg is most notable for his 1853 appointment by President Franklin Pierce as Commissioner to the Kingdom of Hawaii. In this role he was to negotiate its annexation, which he failed to do. The picture of Mr. Gregg on his Wikipedia entry is a very faded grayish brown, and is either a competent drawing or a bad photograph of a young looking man with small glasses, a receding hairline, and a pleasant not-quite smile on his face. It occurs to me")
        ]),
    BookModel(
        author: 'Mensah Otabil',
        totalPage: 20,
        currentPage: 2,
        coverImageUrl: AppImages.trendingBookImageTwo,
        title:
            'The Future of Artificial Intelligence: How AI is Reshaping Our World',
        pages: [
          Pages(
              pageNumber: 1,
              content:
                  "Mr. Gregg is most notable for his 1853 appointment by President Franklin Pierce as Commissioner to the Kingdom of Hawaii. In this role he was to negotiate its annexation, which he failed to do. The picture of Mr. Gregg on his Wikipedia entry is a very faded grayish brown, and is either a competent drawing or a bad photograph of a young looking man with small glasses, a receding hairline, and a pleasant not-quite smile on his face. It occurs to me")
        ]),
  ];
}
