import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/app/cache/cache_keys.dart';
import 'package:icgc/core/data/bloc/naming/naming_events.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/features/manual/data/models/naming_ceremoney_variable.dart';

class NamingBloc extends Bloc<NamingEvents, NamingStates> {
  var box = Hive.box<NamingCeremoneyVariable>(CacheKeys.namingKey);
  NamingBloc() : super(NamingInitialState()) {
    on<LoadNamingEvent>(
      (event, emit) async {
        emit(NamingProcessingState());
        final book = await loadJsonData(event.path);
        emit(NamingLoadedState(book));
      },
    );
    on<SaveNamingCeremonyEvent>(
      (event, emit) async {
        emit(NamingProcessingState());
        await box.add(event.bookModel);
        add(LoadNamingEvent(event.path));
      },
    );
  }
  Future<BookModel> loadJsonData(String path) async {
    // Load the JSON string from the assets
    final String jsonString =
        await rootBundle.loadString('assets/json/$path.json');

    final jsonData = json.decode(jsonString);
    // Decode JSON string into a Dart map or list
    final book = BookModel.fromMap(jsonData);

    return book;
    // Use the data (this can be cast or used directly depending on your JSON structure)
  }
}
