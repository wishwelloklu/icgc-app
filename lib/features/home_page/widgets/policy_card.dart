import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/utils/screen_size.dart';
import '../../manual/data/models/policy_model.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard({
    super.key,
    required this.book,
  });

  final PolicyModel book;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.buttonBorderColor)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/policy_image.png',
          fit: BoxFit.fill,
          height: isTablet
              ? isPortrait
                  ? height * .25
                  : height * .4
              : height * .25,
          width: isTablet
              ? isPortrait
                  ? width * .3
                  : width * .2
              : width * .4,
        ),
      ),
    );
  }
}
