import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_raduis.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/svg_icon.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool showClearIcon;
  final Widget prefixIcon;
  final Icon suffixIcon;
  final Color? borderColor;
  final Color background;
  final FocusNode? focusNode;
  final void Function(String text)? onChange;
  final VoidCallback? onTap;
  final Function(PointerDownEvent event)? onTapOutside;
  const SearchTextField({
    super.key,
    required this.controller,
    this.onTap,
    this.focusNode,
    this.labelText = '',
    this.hintText = 'Search for topic, titles, or authors',
    this.showClearIcon = false,
    this.onTapOutside,
    this.background = AppColor.pageBorder,
    this.prefixIcon = const SvgIcon(
      icon: AppImages.search,
      size: 20,
    ),
    this.suffixIcon = const Icon(Icons.visibility),
    this.borderColor,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      onTapOutside: (event) {
        if (onTapOutside != null) {
          onTapOutside!(event);
        }
      },
      onTap: onTap,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.inputHeight, horizontal: AppPadding.width),
        isDense: true,
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: const SvgIcon(icon: AppImages.search),
        ),
        fillColor: AppColor.textInputField,
        filled: true,
        
        hintStyle: AppTextStyle.appInputText(),
        border: OutlineInputBorder(
            borderSide: borderColor != null
                ? BorderSide(color: borderColor!, width: 1)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.small)),
        enabledBorder: OutlineInputBorder(
            borderSide: borderColor != null
                ? BorderSide(color: borderColor!, width: 1)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.small)),
        focusedBorder: OutlineInputBorder(
            borderSide: borderColor != null
                ? BorderSide(color: borderColor!, width: 1)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.small)),
      ),
    );
  }
}
