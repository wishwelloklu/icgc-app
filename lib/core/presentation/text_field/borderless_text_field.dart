import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class BorderlessTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String Function(String? value)? validator;
  final bool isEmail;
  final bool isSuggest;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final void Function(String value) onChanged;
  final Widget? suffixIcon;
  final VoidCallback onTap;
  const BorderlessTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.validator,
    this.isEmail = false,
    this.isSuggest = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    required this.onChanged,
    required this.onTap,
    this.suffixIcon,
  });

  @override
  _BorderlessTextFieldState createState() => _BorderlessTextFieldState();
}

class _BorderlessTextFieldState extends State<BorderlessTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTap: widget.onTap,
      style: AppTextStyle.appInputText(),
      onChanged: (value) => widget.onChanged(value),
      enableSuggestions: widget.isSuggest,
      keyboardType: widget.isEmail ? TextInputType.text : widget.textInputType,
      textCapitalization:
          widget.isEmail ? TextCapitalization.none : widget.textCapitalization,
      cursorHeight: 14,
      cursorWidth: 1.5,
      decoration: InputDecoration(
        hintText: widget.hintText,
        isDense: true,
        hintStyle: AppTextStyle.appInputHint(),
        suffix: widget.suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.all(Radius.circular(AppPadding.textFieldRadius)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.all(Radius.circular(AppPadding.textFieldRadius)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.all(Radius.circular(AppPadding.textFieldRadius)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusColor: AppColor.primaryColor,
      ),
    );
  }
}
