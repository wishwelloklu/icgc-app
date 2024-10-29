import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_spacer.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/presentation/text/label_text.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? validationText;
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.validationText,
    this.labelText = '',
    this.hintText = '',
    this.obscureText = true,
    this.suffixIcon = const Icon(Icons.visibility),
  });

  @override
  _PasswordTextField createState() => _PasswordTextField();
}

class _PasswordTextField extends State<PasswordTextField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelText(text: widget.labelText),
        AppSpacer.verticalSpace(height: AppPadding.extraSmall),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: AppPadding.buttonHeight,
          child: TextFormField(
            controller: widget.controller,
            style: AppTextStyle.appInputText(),
            obscureText: _isObscured,
            validator: (value) {
              // RegExp regex = RegExp(ConstantConfig.emailPattern);
              if (value == null || value.isEmpty) {
                return widget.validationText ?? "Enter your password";
              }
              //  else if (!regex.hasMatch(value)) {
              //   return "Please enter a valid email address";
              // }
              return null;
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyle.appInputHint(),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: AppPadding.inputHeight,
                  horizontal: AppPadding.width),
              isDense: true,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Text(
                        _isObscured ? 'Show' : 'Hide',
                        style: AppTextStyle.appDescription(
                            color: AppColor.primaryColor,
                            size: AppFontSize.small),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : widget.suffixIcon,
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
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.redColor),
              ),
              focusColor: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
