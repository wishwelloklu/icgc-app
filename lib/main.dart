import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/features/sermons/data/models/sample_model.dart';
import 'app/cache/cache_keys.dart';
import 'features/library/data/models/notes_item_model.dart';
import 'features/manual/data/models/naming_ceremoney_variable.dart';
import 'app.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  Hive.registerAdapter(NotesItemModelAdapter());
  Hive.registerAdapter(NamingCeremoneyVariableAdapter());
  Hive.registerAdapter(SampleModelAdapter());
  await Hive.openBox<NotesItemModel>(CacheKeys.notesKey);
  await Hive.openBox<SampleModel>(CacheKeys.officiate);
  await Hive.openBox<bool>('device');
  await Hive.openBox<NamingCeremoneyVariable>(CacheKeys.namingKey);
 
  runApp(const App());
}
