import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../app/cache/cache_keys.dart';
import 'naming_events.dart';
import 'naming_states.dart';
import '../../models/book/book_model.dart';
import '../../../../features/manual/data/models/naming_ceremoney_variable.dart';

class NamingBloc extends Bloc<NamingEvents, NamingStates> {
  var box = Hive.box<NamingCeremoneyVariable>(CacheKeys.namingKey);
  final path = 'naming_home';
  NamingBloc() : super(NamingInitialState()) {
    on<LoadNamingEvent>(
      (event, emit) async {
        emit(NamingProcessingState());
        final book = await loadJsonData(event.path);
        emit(NamingLoadedState(book));
      },
    );

    on<LoadAllNamingEvent>(
      (event, emit) async {
        emit(NamingProcessingState());
        final book = box.values.toList();
        emit(AllNamingLoadedState(book));
      },
    );
    on<SaveNamingCeremonyEvent>(
      (event, emit) async {
        await box.add(event.bookModel);
        add(LoadNamingEvent(path));
      },
    );

    on<DeleteNamingCeremonyEvent>(
      (event, emit) async {
        await box.deleteAt(event.index);
        final book = box.values.toList();
        emit(AllNamingLoadedState(book));
      },
    );

    on<UpdateNamingCeremonyEvent>(
      (event, emit) async {
        await box.putAt(event.index, event.updatedData);
        final book = box.values.toList();
        emit(AllNamingLoadedState(book));
      },
    );

    on<DeleteAllNamingCeremonyEvent>((event, emit) => box.clear());
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

  Future<BookModel> _loadJsonData(String path) async {
    // Run the decryption in a different isolate using `compute`
    return await compute(_isolateLoadJson, {'path': path});
  }
}

// This function runs in the isolate
Future<BookModel> _isolateLoadJson(Map<String, dynamic> args) async {
  final path = args['path'];

  final String jsonString =
      await rootBundle.loadString('assets/json/$path.json');

  final jsonData = json.decode(jsonString);
  // Decode JSON string into a Dart map or list
  final book = BookModel.fromMap(jsonData);

  return book;
}
