import 'package:flutter/material.dart';
import '../../../app/config/constant_config.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_spacer.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/screen_size.dart';
import '../text/label_text.dart';

import '../../../app/theme/app_padding.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String? value)? validator;
  final bool isEmail;
  final bool isSuggest;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final bool isRequired;
  final Function(PointerDownEvent value)? onTapOutSide;
  final Widget? labelTrail;
  final bool multiLine;
  const InputTextField({
    super.key,
    required this.controller,
    this.onTapOutSide,
    this.labelText = '',
    this.hintText = '',
    this.validator,
    this.isEmail = false,
    this.isSuggest = false,
    this.isRequired = false,
    this.labelTrail,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return Column(
      children: [
        LabelText(
          text: isRequired ? labelText : '$labelText (Optional)',
        ),
        AppSpacer.verticalSpace(height: AppPadding.extraSmall),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: controller,
            onTapOutside: onTapOutSide,
            style: AppTextStyle.appInputText(
                size: isTablet ? AppFontSize.normal : AppFontSize.medium),
            validator: validator != null
                ? (value) => validator!(value)
                : isEmail
                    ? (value) {
                        RegExp regex = RegExp(ConstantConfig.emailPattern);
                        if (value == null || value.isEmpty) {
                          return "$labelText field is required";
                        } else if (!regex.hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      }
                    : isRequired
                        ? (text) {
                            if (text == null || text.isEmpty) {
                              return "$labelText field is required";
                            }
                            return null;
                          }
                        : null,
            maxLines: multiLine ? null : 1,
            minLines: multiLine ? 2 : null,
            enableSuggestions: isSuggest,
            keyboardType: isEmail ? TextInputType.emailAddress : textInputType,
            textCapitalization:
                isEmail ? TextCapitalization.none : textCapitalization,
            decoration: InputDecoration(
              hintText: hintText,
              isDense: true,
              fillColor: AppColor.textInputField,
              filled: true,
              hintStyle: isTablet
                  ? AppTextStyle.tabletAppInputText()
                  : AppTextStyle.appInputHint(),
              contentPadding: EdgeInsets.symmetric(
                  vertical: isTablet
                      ? (AppPadding.tabletInputHeight)
                      : (AppPadding.inputHeight),
                  horizontal: AppPadding.width),
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
              focusColor: AppColor.tertiaryColor,
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.redColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppPadding.textFieldRadius),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
