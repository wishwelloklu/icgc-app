import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/manual/data/bloc/manual_page_event.dart';
import 'package:icgc/features/manual/data/bloc/manual_page_state.dart';

class ManualPageBloc extends Bloc<ManualPageEvent, ManualPageState> {
  ManualPageBloc() : super(const ManualPageState(0)) {
    on<ManualPageEvent>((event, emit) => emit(ManualPageState(event.index)));
  }
}
