import 'package:flutter/material.dart';
import 'package:icgc/app/config/constant_config.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_spacer.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/presentation/text/label_text.dart';

import '../../../../../app/theme/app_padding.dart';


class InputTextField extends StatefulWidget {
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
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          LabelText(
            text: widget.labelText,
          ),
    
        AppSpacer.verticalSpace(height: AppPadding.extraSmall),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: widget.controller,
            onTapOutside: widget.onTapOutSide,
            style: AppTextStyle.appInputText(),
          
            validator: widget.validator != null
                ? (value) => widget.validator!(value)
                : widget.isEmail
                    ? (value) {
                        RegExp regex = RegExp(ConstantConfig.emailPattern);
                        if (value == null || value.isEmpty) {
                          return "${widget.labelText} field is required";
                        } else if (!regex.hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      }
                    : widget.isRequired
                        ? (text) {
                            if (text == null || text.isEmpty) {
                              return "${widget.labelText} field is required";
                            }
                            return null;
                          }
                        : null,
            enableSuggestions: widget.isSuggest,
            keyboardType: widget.isEmail
                ? TextInputType.emailAddress
                : widget.textInputType,
            textCapitalization: widget.isEmail
                ? TextCapitalization.none
                : widget.textCapitalization,
            decoration: InputDecoration(
              hintText: widget.hintText,
              isDense: true,
              fillColor: AppColor.textInputField,
              filled: true,
              hintStyle: AppTextStyle.appInputHint(),
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
