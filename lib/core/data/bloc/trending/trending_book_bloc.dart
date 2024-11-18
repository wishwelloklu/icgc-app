import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trending_book_events.dart';
import 'trending_book_states.dart';
import '../../models/book/book_model.dart';

class TrendingBookBloc extends Bloc<TrendingBookEvents, TrendingBookStates> {
  TrendingBookBloc() : super(TrendingBookInitialState()) {
    on<LoadTrendingBookEvent>(
      (event, emit) async {
        emit(TrendingBookProcessingState());
        final bookList = await loadJsonData();
        emit(TrendingBookLoadedState(bookList));
      },
    );
  }
  Future<List<BookModel>> loadJsonData() async {
    // Load the JSON string from the assets
    final String jsonString =
        await rootBundle.loadString('assets/json/json_doc.json');

    List<dynamic> jsonData = json.decode(jsonString);
    // Decode JSON string into a Dart map or list
    final bookList = jsonData.map((item) => BookModel.fromMap(item)).toList();

    return bookList;
    // Use the data (this can be cast or used directly depending on your JSON structure)
  }
}
