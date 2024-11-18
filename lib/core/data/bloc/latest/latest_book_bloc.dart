import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'latest_book_events.dart';
import 'latest_book_states.dart';
import '../../models/book/book_model.dart';

class LatestBookBloc extends Bloc<LatestBookEvents, LatestBookStates> {
  LatestBookBloc() : super(LatestBookInitialState()) {
    on<LoadLatestBookEvent>(
      (event, emit) async {
        emit(LatestBookProcessingState());
        final bookList = await loadJsonData();
        emit(LatestBookLoadedState(bookList));
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
