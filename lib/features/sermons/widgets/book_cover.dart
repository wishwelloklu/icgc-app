import 'package:flutter/material.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
    this.showSampleText = true,
  });
  final String title;
  final String subTitle;
  final Color color;
  final bool showSampleText;
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color,
                darkenColor(color),
              ],
            ),
          ),
        ),
        Positioned(
          left: 1,
          child: Container(
            height: height,
            width: 5,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(-3, 0),
                  spreadRadius: .2,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 12,
          child: Container(
            height: height,
            width: 5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color,
                  offset: const Offset(-3, 0),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
                const BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  spreadRadius: .2,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 25,
          right: 15,
          top: 30,
          bottom: 20,
          child: TitleText(
            maxLine: 3,
            text: title,
            fontSize: isTablet
                ? 30
                : showSampleText
                    ? 20
                    : 15,
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        ),
        if (showSampleText)
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: TitleText(
              text: 'Sample Sermon',
              fontSize: isTablet ? 20 : 15,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
