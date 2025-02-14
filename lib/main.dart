import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/core/data/models/color_model.dart';
import 'package:icgc/features/sermons/data/models/sermon_model.dart';
import 'package:icgc/features/sermons/data/models/tag.dart';
import 'app/cache/cache_keys.dart';
import 'app/config/push_notification.dart';
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
  Hive.registerAdapter(SermonModelAdapter());
  Hive.registerAdapter(ColorModelAdapter());
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox<NotesItemModel>(CacheKeys.notesKey);
  await Hive.openBox<SermonModel>(CacheKeys.officiate);
  await Hive.openBox<bool>('device');
  await Hive.openBox<NamingCeremoneyVariable>(CacheKeys.namingKey);
  await PushNotificationService.initLocalNotificaton();
  runApp(const App());
}
