import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/data/bloc/latest/latest_book_bloc.dart';
import 'package:icgc/core/data/bloc/latest/latest_book_events.dart';
import 'package:icgc/core/data/bloc/trending/trending_book_bloc.dart';
import 'package:icgc/core/data/bloc/trending/trending_book_events.dart';
import 'core/data/bloc/book/book_bloc.dart';
import 'core/data/bloc/book/book_events.dart';
import 'core/data/bloc/naming/naming_bloc.dart';
import 'features/auth/blocs/auth_bloc.dart';
import 'features/library/data/bloc/notes/notes_bloc.dart';
import 'features/manual/data/bloc/policy_bloc/policy_bloc.dart';
import 'features/manual/data/bloc/policy_bloc/policy_events.dart';
import 'features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get getBlocProviders {
  return [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(create: (_) => NotesBloc()),
    BlocProvider(create: (_) => FontBloc()),
    BlocProvider(create: (_) => BookBloc()..add(LoadBookEvent())),
    BlocProvider(create: (_) => LatestBookBloc()..add(LoadLatestBookEvent())),
    BlocProvider(
        create: (_) => TrendingBookBloc()..add(LoadTrendingBookEvent())),
    BlocProvider(create: (_) => NamingBloc()),
    BlocProvider(create: (_) => PolicyBloc()..add(LoadPolicyEvent())),
  ];
}
