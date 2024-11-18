import 'package:flutter/material.dart';

class NamingCustomeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final String child;
  final String father;
  final String? parent;

  const NamingCustomeText(this.text, this.fontSize,
      {super.key, required this.child, required this.father, this.parent});

  List<TextSpan> parseText(String text) {
    // Updated regex to handle bold (*b), italic (*t), custom markers, and placeholders
    final regex = RegExp(
        r'(\*b(.*?)\*b)|(\*t(.*?)\*t)|(\*cc(.*?)\*cc)|(\*nc)|(\*fn)|(\*pn)');
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

      // Apply style based on the detected group, using safe access for each group
      if (match.group(2) != null) {
        // Bold
        final sub = match.group(2)!.toLowerCase().contains('sample prayer')
            ? '${match.group(2)}:'
            : match.group(2);
        spans.add(TextSpan(
          text: sub,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ));
      } else if (match.group(4) != null) {
        // Italic
        spans.add(TextSpan(
          text: '\n${match.group(4)}\n',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: fontSize),
        ));
      } else if (match.group(6) != null) {
        // Centered or custom styling
        spans.add(TextSpan(
          text: match.group(6),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ));
      } else if (match.group(7) != null) {
        // Child placeholder
        spans.add(TextSpan(
          text: child,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ));
      } else if (match.group(8) != null) {
        // Father placeholder
        spans.add(TextSpan(
          text: father,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ));
      } else if (match.group(9) != null) {
        // Parent placeholder
        spans.add(TextSpan(
          text: parent,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
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
