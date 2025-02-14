import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/config/constant_config.dart';
import 'font_events.dart';

import 'font_states.dart';

// Bloc
class FontBloc extends Bloc<FontEvents, FontState> {
  String _fontName = ConstantConfig.satoshi;

  double _fontSize = 14;
  FontBloc() : super(const FontState(14, ConstantConfig.satoshi)) {
    on<LoadBookEvent>(
      (event, emit) {
        // Logic to initialize or reset font size, e.g., from saved state
        emit(FontState(14, _fontName)); // or some loaded value
      },
    );

    on<UpdateFontSizeEvent>(
      (event, emit) {
        _fontSize = event.fontSize;
        emit(FontState(event.fontSize, _fontName));
      },
    );

    on<UpdateFontFamillyEvent>(
      (event, emit) {
        _fontName = event.fontName;
        emit(FontState(_fontSize, event.fontName));
      },
    );
  }
}
