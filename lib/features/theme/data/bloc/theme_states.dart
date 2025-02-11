import 'package:equatable/equatable.dart';
import 'package:icgc/features/theme/data/models/theme_model.dart';

abstract class ThemeStates extends Equatable {}

class InitialThemeState extends ThemeStates {
  @override
  List<Object?> get props => [];
}

class ThemeLoadedState extends ThemeStates {
  final List<ThemeModel> themes;
  ThemeLoadedState(this.themes);
  @override
  List<Object?> get props => [themes];
}

class ThemeErrorState extends ThemeStates {
  final String error;
  ThemeErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

