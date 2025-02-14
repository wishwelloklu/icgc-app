import 'package:flutter/material.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

import 'line_paint.dart';

class SermonCover extends StatelessWidget {
  const SermonCover({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
  });
  final String title;
  final String subTitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.center,
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
          top: 0,
          bottom: 0,
          child: Container(
            height: height,
            width: 3,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(-3, 0),
                  spreadRadius: .1,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 12,
          top: 0,
          bottom: 0,
          child: Container(
            height: height,
            width: 1,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: TitleText(
              maxLine: 3,
              text: title,
              fontSize: isTablet ? 15 : 12,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 13),
          child: CustomPaint(
            painter: LinePaint(),
          ),
        )
      ],
    );
  }
}
