extension StringExtension on String {
  String get initial {
    final tokens = split(' ');
    return tokens.first[0];
  }

  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
