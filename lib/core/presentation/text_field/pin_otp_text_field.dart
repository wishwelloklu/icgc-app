import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import '../../../app/theme/app_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../app/utils/screen_size.dart';
import '../text/label_text.dart';

class PinOrOTPTextField extends StatefulWidget {
  const PinOrOTPTextField({
    super.key,
    required this.pinController,
    this.length = 6,
    this.labelText,
    this.focusNode,
    required this.onCompleted,
  });

  final TextEditingController pinController;
  final int length;
  final String? labelText;
  final FocusNode? focusNode;
  final void Function(String pin) onCompleted;

  @override
  State<PinOrOTPTextField> createState() => _PinOrOTPTextFieldState();
}

class _PinOrOTPTextFieldState extends State<PinOrOTPTextField> {
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return Column(
      children: [
        if (widget.labelText != null)
          LabelText(
            text: widget.labelText!,
          ),
        if (widget.labelText != null) const Gap(10),
        PinCodeTextField(
          length: widget.length,
          obscureText: false,
          animationType: AnimationType.fade,
          cursorColor: AppColor.tertiaryColor,
          keyboardType: TextInputType.number,
          focusNode: widget.focusNode,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: isTablet ? 70 : 45,
            fieldWidth: isTablet ? 70 : 45,
            activeFillColor: AppColor.textInputFieldBorder,
            activeColor: AppColor.textInputFieldBorder,
            inactiveFillColor: AppColor.whiteColor,
            selectedColor: AppColor.primaryColor,
            errorBorderColor: AppColor.redColor,
            inactiveColor: AppColor.textInputFieldBorder,
            selectedFillColor: AppColor.whiteColor,
            activeBorderWidth: 2,
            inactiveBorderWidth: 1,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: widget.pinController,
          onCompleted: (pin) => widget.onCompleted(pin),
          onChanged: (value) {},
          beforeTextPaste: (text) {
            return true;
          },
          appContext: context,
        ),
      ],
    );
  }
}
