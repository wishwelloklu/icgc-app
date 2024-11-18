import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_images.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_raduis.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/svg_icon.dart';

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
  final double? height;
  final void Function(String text)? onChange;
  final VoidCallback? onTap;
  final Function(PointerDownEvent event)? onTapOutside;
  const SearchTextField({
    super.key,
    required this.controller,
    this.onTap,
    this.focusNode,
    this.height,
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
    return SizedBox(
      height: 40,
      child: TextField(
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
          contentPadding: EdgeInsets.symmetric(
              vertical: height ?? AppPadding.inputHeight,
              horizontal: AppPadding.width),
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
      ),
    );
  }
}
