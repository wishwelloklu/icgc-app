import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_raduis.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/svg_icon.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool showClearIcon;
  final Widget prefixIcon;
  final Icon suffixIcon;
  final Color? borderColor;
  final Color background;
  final void Function(String text)? onChange;
  final Function(PointerDownEvent event)? onTapOutside;
  const SearchTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    this.hintText = 'Search...',
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
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.showClearIcon;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscured,
      onChanged: widget.onChange,
      onTapOutside: (event) {
        if (widget.onTapOutside != null) {
          widget.onTapOutside!(event);
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: widget.prefixIcon,
        ),
        fillColor: widget.background,
        hintStyle: AppTextStyle.appInputText(),
        contentPadding: EdgeInsets.zero,
        filled: true,
        suffixIcon: widget.showClearIcon
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.search : Icons.close,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
            borderSide: widget.borderColor != null
                ? BorderSide(color: widget.borderColor!)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.small)),
      ),
    );
  }
}
