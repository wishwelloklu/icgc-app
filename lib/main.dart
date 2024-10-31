import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/app/cache/cache_keys.dart';
import 'package:icgc/features/library/data/models/notes_item_model.dart';
import 'package:icgc/features/manual/data/models/naming_ceremoney_variable.dart';

import 'app.dart';

void main() async {
  // await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  Hive.registerAdapter(NotesItemModelAdapter());
  Hive.registerAdapter(NamingCeremoneyVariableAdapter());
  await Hive.openBox<NotesItemModel>(CacheKeys.notesKey);
  await Hive.openBox<NamingCeremoneyVariable>(CacheKeys.namingKey);

  runApp(const App());
}
