import 'package:equatable/equatable.dart';

// State

 class FontState extends Equatable {
  final double fontSize;
  final String fontName;

  const FontState(this.fontSize, this.fontName);

  @override
  List<Object?> get props => [fontSize, fontName];
}
