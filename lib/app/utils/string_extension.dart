extension StringExtension on String {
  String get initial {
    final tokens = split(' ');
    return tokens.first[0];
  }
}
