// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_images.dart';

class BookModel extends Equatable {
  final UniqueKey id = UniqueKey();
  final String title;
  final String description;
  final int totalPage;
  final int currentPage;
  final String author;
  final String coverImageUrl;
  BookModel({
    required this.title,
    required this.description,
    required this.totalPage,
    required this.currentPage,
    required this.author,
    required this.coverImageUrl,
  });

  @override
  List<Object> get props {
    return [
      title,
      description,
      totalPage,
      currentPage,
      author,
      coverImageUrl,
    ];
  }

  static List<BookModel> trendingBookList = [
    BookModel(
      title: 'Book title 1',
      description: 'Some book description here for a short introdunction',
      totalPage: 20,
      currentPage: 2,
      author: 'Wishwell Oklu',
      coverImageUrl: AppImages.trendingBookImageOne,
    ),
     BookModel(
      title: 'Book title 2',
      description: 'Some book description here for a short introdunction',
      totalPage: 20,
      currentPage: 2,
      author: 'Wishwell Oklu',
      coverImageUrl: AppImages.trendingBookImageTwo,
    ),
     BookModel(
      title: 'Book title 3',
      description: 'Some book description here for a short introdunction',
      totalPage: 20,
      currentPage: 2,
      author: 'Wishwell Oklu',
      coverImageUrl: AppImages.trendingBookImageOne,
    ),
     BookModel(
      title: 'Book title 4',
      description: 'Some book description here for a short introdunction',
      totalPage: 20,
      currentPage: 2,
      author: 'Wishwell Oklu',
      coverImageUrl: AppImages.trendingBookImageTwo,
    ),
  ];
}
