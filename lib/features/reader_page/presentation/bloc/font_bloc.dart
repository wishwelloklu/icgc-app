import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_events.dart';

import 'font_states.dart';

// Bloc
class FontBloc extends Bloc<FontEvents, FontStates> {
  FontBloc() : super(const FontState(14)) {
    on<LoadBookEvent>(
      (event, emit) {
        // Logic to initialize or reset font size, e.g., from saved state
        emit(const FontState(14)); // or some loaded value
      },
    );

    on<UpdateFontEvent>(
      (event, emit) {
        emit(FontState(event.fontSize));
        print(event.fontSize);
      },
    );
  }
}
