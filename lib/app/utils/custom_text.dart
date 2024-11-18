import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final String text;
  final String fontName;
  final String searchText;
  final double fontSize;
  final int? maxLine;
  const CustomeText(this.text, this.fontSize,
      {super.key, this.maxLine, required this.searchText, required this.fontName});

  List<TextSpan> parseText(String text) {
    // Updated regex to handle bold (*b) and italic (*t) text
    final regex = RegExp(r'(\*b(.*?)\*b)|(\*t(.*?)\*t)|(\*cc(.*?)\*cc)');
    final matches = regex.allMatches(text);

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in matches) {
      // Add non-styled text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: TextStyle(
                fontSize: fontSize, fontFamily: fontName)));
      }

      // Apply style based on the detected group
      if (match.group(2) != null) {
        // Bold
        spans.add(TextSpan(
          text: match.group(2),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              fontFamily: fontName),
        ));
      } else if (match.group(4) != null) {
        // Italic
        spans.add(TextSpan(
          text: match.group(4),
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: fontSize,
              fontFamily: fontName),
        ));
      }

      lastMatchEnd = match.end;
    }

    // Add remaining text after the last match
    if (lastMatchEnd < text.length) {
      print('notempty ${searchText.isNotEmpty}');
      spans.add(TextSpan(
          text: text.substring(lastMatchEnd),
          style: TextStyle(
              fontSize: fontSize, fontFamily: fontName)));
    }
    if (searchText.isNotEmpty) {
      final searchRegex =
          RegExp(RegExp.escape(searchText), caseSensitive: false);
      final matches = searchRegex.allMatches(text).toList();
      for (final match in matches) {
        spans.add(TextSpan(
          text: match.group(0),
          style:  TextStyle(
            fontFamily: fontName,
            backgroundColor: Colors.yellow, // Highlight color
          ),
        ));
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: parseText(text)),
      maxLines: maxLine,
    );
  }
}
