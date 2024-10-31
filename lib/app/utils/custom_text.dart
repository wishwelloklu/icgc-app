import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomeText(this.text, this.fontSize, {super.key});

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
            style: TextStyle(fontSize: fontSize)));
      }

      // Apply style based on the detected group
      if (match.group(2) != null) {
        // Bold
        spans.add(TextSpan(
          text: match.group(2),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ));
      } else if (match.group(4) != null) {
        // Italic
        spans.add(TextSpan(
          text: match.group(4),
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: fontSize),
        ));
      }

      lastMatchEnd = match.end;
    }

    // Add remaining text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
          text: text.substring(lastMatchEnd),
          style: TextStyle(fontSize: fontSize)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: parseText(text)),
    );
  }
}
