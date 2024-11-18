import 'package:equatable/equatable.dart';

// State
abstract class FontStates extends Equatable {
  const FontStates();
}

final class FontState extends FontStates {
  final double fontSize;
  final String fontName;

  const FontState(this.fontSize, this.fontName);

  @override
  List<Object?> get props => [fontSize, fontName];
}
