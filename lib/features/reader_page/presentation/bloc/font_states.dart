import 'package:equatable/equatable.dart';

// State
abstract class FontStates extends Equatable {
  const FontStates();
}

final class FontState extends FontStates {
  final double fontSize;

  const FontState(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}
