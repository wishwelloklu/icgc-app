import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_spacer.dart';
import '../../../app/theme/app_text_style.dart';

import '../text/label_text.dart';

class IconTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon suffixIcon;
  final Color borderColor;
  final VoidCallback? onTap;
  final bool isRequired;
  const IconTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.obscureText = false,
    this.isRequired = false,
    this.prefixIcon,
    this.suffixIcon = const Icon(Icons.keyboard_arrow_down),
    this.borderColor = Colors.blue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelText(
          text: labelText,
        ),
        AppSpacer.verticalSpace(height: AppPadding.extraSmall),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: controller,
            onTap: onTap,
            readOnly: true,
            validator: isRequired
                ? (text) {
                    if (text == null || text.isEmpty) {
                      return "$labelText field is required";
                    }
                    return null;
                  }
                : null,
            style: AppTextStyle.appInputText(),
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: prefixIcon,
                hintStyle: AppTextStyle.appInputHint(),
                suffixIcon: suffixIcon,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                focusColor: AppColor.primaryColor),
          ),
        ),
      ],
    );
  }
}
