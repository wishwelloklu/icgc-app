import 'package:equatable/equatable.dart';
import 'package:icgc/features/prayer/data/prayer_model.dart';

abstract class PrayerStates extends Equatable {}

class InitialPrayerState extends PrayerStates {
  @override
  List<Object?> get props => [];
}

class PrayerLoadedState extends PrayerStates {
  final List<PrayerModel> prayers;
  PrayerLoadedState(this.prayers);
  @override
  List<Object?> get props => [prayers];
}

class PrayerErrorState extends PrayerStates {
  final String error;
  PrayerErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

