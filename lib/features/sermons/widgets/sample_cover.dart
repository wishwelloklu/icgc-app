import 'package:flutter/material.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

import 'line_paint.dart';

class SampleCover extends StatelessWidget {
  const SampleCover({
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
            width: 3,
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
            width: 3,
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
                ? 20
                : 20
                    ,
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        ),
    
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
        Container(
          margin:
              const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 15),
          child: CustomPaint(
            painter: LinePaint(),
          ),
        )
      ],
    );
  }
}
