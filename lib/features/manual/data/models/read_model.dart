import 'package:flutter/material.dart';
import '../../../../core/data/models/book/book_model.dart';

class ReadModel {
  final Color color;
  final BookModel book;
  final String? image;
  final int currentPage;
  ReadModel({required this.color, required this.book, this.currentPage = 0, this.image});
}
