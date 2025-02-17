import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/data/bloc/latest/latest_book_bloc.dart';
import 'package:icgc/core/data/bloc/latest/latest_book_events.dart';
import 'package:icgc/core/data/bloc/trending/trending_book_bloc.dart';
import 'package:icgc/core/data/bloc/trending/trending_book_events.dart';
import 'package:icgc/features/manual/data/bloc/manual_page_bloc.dart';
import 'package:icgc/features/notifications/data/bloc/notification_bloc.dart';
import 'package:icgc/features/others/data/bloc/others_bloc.dart';
import 'package:icgc/features/prayer/data/bloc/prayer_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_bloc.dart';
import 'package:icgc/features/theme/data/bloc/theme_bloc.dart';
import 'core/data/bloc/book/book_bloc.dart';
import 'core/data/bloc/book/book_events.dart';
import 'core/data/bloc/naming/naming_bloc.dart';
import 'core/data/bloc/nav_bar_bloc/nav_bar_bloc.dart';
import 'features/auth/blocs/auth_bloc.dart';
import 'features/library/data/bloc/notes/notes_bloc.dart';
import 'features/policy/data/bloc/policy_bloc/policy_bloc.dart';
import 'features/policy/data/bloc/policy_bloc/policy_events.dart';
import 'features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get getBlocProviders {
  return [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(create: (_) => NotesBloc()),
    BlocProvider(create: (_) => FontBloc()),
    BlocProvider(create: (_) => NotificationBloc()),
    BlocProvider(create: (_) => SampleBloc()),
    BlocProvider(create: (_) => ThemeBloc()),
    BlocProvider(create: (_) => NavBarBloc()),
    BlocProvider(create: (_) => SermonBloc()),
    BlocProvider(create: (_) => ManualPageBloc()),
    BlocProvider(create: (_) => OthersBloc()),
    BlocProvider(create: (_) => PrayerBloc()),
    BlocProvider(create: (_) => BookBloc()..add(LoadBookEvent())),
    BlocProvider(create: (_) => LatestBookBloc()..add(LoadLatestBookEvent())),
    BlocProvider(
        create: (_) => TrendingBookBloc()..add(LoadTrendingBookEvent())),
    BlocProvider(create: (_) => NamingBloc()),
    BlocProvider(create: (_) => PolicyBloc()..add(LoadPolicyEvent())),
  ];
}
