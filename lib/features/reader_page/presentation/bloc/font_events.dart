import 'package:equatable/equatable.dart';

abstract class FontEvents extends Equatable {
  const FontEvents();
}

final class LoadBookEvent extends FontEvents {
  @override
  List<Object?> get props => [];
}

final class UpdateFontEvent extends FontEvents {
  final double fontSize;

  const UpdateFontEvent(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}
