// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ManualPageState extends Equatable {
  final int index;
  const ManualPageState(this.index);

  ManualPageState copyWith({
    int? index,
  }) {
    return ManualPageState(
      index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [index];
}
