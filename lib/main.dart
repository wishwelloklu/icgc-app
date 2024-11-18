import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/cache/cache_keys.dart';
import 'features/library/data/models/notes_item_model.dart';
import 'features/manual/data/models/naming_ceremoney_variable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  Hive.registerAdapter(NotesItemModelAdapter());
  Hive.registerAdapter(NamingCeremoneyVariableAdapter());
  await Hive.openBox<NotesItemModel>(CacheKeys.notesKey);
  await Hive.openBox<NamingCeremoneyVariable>(CacheKeys.namingKey);
 
  runApp(const App());
}
