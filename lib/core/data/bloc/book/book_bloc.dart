import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_events.dart';
import 'book_states.dart';
import '../../models/book/book_model.dart';

class BookBloc extends Bloc<BookEvents, BookStates> {
  BookBloc() : super(BookInitialState()) {
    on<LoadBookEvent>(
      (event, emit) async {
        emit(BookProcessingState());
        final bookList = await loadJsonData();
        emit(BookLoadedState(bookList));
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
