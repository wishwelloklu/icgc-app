import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/auth/blocs/auth_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get getBlocProviders {
  return [
    BlocProvider(create: (_) => AuthBloc()),
  ];
}
