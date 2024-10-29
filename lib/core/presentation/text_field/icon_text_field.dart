import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_spacer.dart';
import 'package:icgc/app/theme/app_text_style.dart';

import '../text/label_text.dart';

class IconTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon suffixIcon;
  final Color borderColor;
  final VoidCallback? onTap;
  const IconTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.obscureText = false,
    this.prefixIcon,
    required this.suffixIcon,
    this.borderColor = Colors.blue,
    this.onTap,
  });

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<IconTextField> {
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
        LabelText(
          text: widget.labelText,
        ),
        AppSpacer.verticalSpace(height: AppPadding.extraSmall),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: widget.controller,
            obscureText: _isObscured,
            onTap: widget.onTap,
            readOnly: true,
            style: AppTextStyle.appInputText(),
            decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                hintStyle: AppTextStyle.appInputHint(),
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      )
                    : widget.suffixIcon,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.textInputFieldBorder),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppPadding.textFieldRadius)),
                ),
                focusColor: AppColor.primaryColor),
          ),
        ),
      ],
    );
  }
}
