import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/data/bloc/nav_bar_bloc/nav_bar_event.dart';
import 'package:icgc/core/data/bloc/nav_bar_bloc/nav_bar_states.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarStates> {
  NavBarBloc() : super(NavBarStates(0)) {
    on<NavBarEvent>((event, emit) => emit(NavBarStates(event.index)));
  }
}
