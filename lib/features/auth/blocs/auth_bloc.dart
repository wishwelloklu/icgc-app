import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(InitialAuthState()) {
    on<LoginEvent>((event, emit) {});
  }
}
