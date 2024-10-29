import 'package:flutter/cupertino.dart';

import 'app_padding.dart';

class AppSpacer {
  static Widget horizontalSpace({double width = AppPadding.normal}) {
    return SizedBox(width: width);
  }

  static Widget verticalSpace({double height = AppPadding.normal}) {
    return SizedBox(height: height);
  }
}
