class NavBarStates {
  final int index;

  NavBarStates(this.index);

  NavBarStates copyWith({int? index}) {
    return NavBarStates(
      index ?? this.index,
    );
  }
}
