import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/data/bloc/book/book_bloc.dart';
import 'package:icgc/core/data/bloc/book/book_events.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/features/auth/blocs/auth_bloc.dart';
import 'package:icgc/features/library/data/bloc/notes/notes_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get getBlocProviders {
  return [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(create: (_) => NotesBloc()),
    BlocProvider(create: (_) => FontBloc()),
    BlocProvider(create: (_) => BookBloc()..add(LoadBookEvent())),
    BlocProvider(create: (_) => NamingBloc()),
  ];
}
