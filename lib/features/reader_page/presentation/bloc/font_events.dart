import 'package:equatable/equatable.dart';

abstract class FontEvents extends Equatable {
  const FontEvents();
}

final class LoadBookEvent extends FontEvents {
  @override
  List<Object?> get props => [];
}

final class UpdateFontSizeEvent extends FontEvents {
  final double fontSize;

  const UpdateFontSizeEvent(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}


final class UpdateFontFamillyEvent extends FontEvents {
  final String fontName;
  const UpdateFontFamillyEvent(this.fontName);
  @override
  List<Object?> get props => [fontName];
}
