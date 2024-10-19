import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget suffixIcon;
  final Function(String)? onSubmit;
  final String str;
  final TextEditingController? controller;
  final bool readOnly;
  final Function()? onTap;
  final TextAlign textAlign;
  final bool error;
  final TextInputType? keyboardType;
  final bool digitsOnly;
  final Function(String)? onChanged;
  bool isPassword;
  final TextDirection? textDirection;
  final int? maxLength;
  final double? width;
  final String? Function(String? value)? validate;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  final int? maxLines;
  final FocusNode? focusNode;

  CustomTextFormField(
      {Key? key,
        required this.str,
        this.controller,
        this.readOnly = false,
        this.onTap,
        this.textAlign = TextAlign.start,
        this.error = false,
        this.keyboardType,
        this.digitsOnly = false,
        this.onChanged,
        this.textDirection,
        this.isPassword = false,
        this.maxLength,
        this.width,
        this.onSubmit,
        this.validate,
        this.inputFormatters,
        this.autovalidateMode = AutovalidateMode.onUserInteraction,
        this.maxLines,
        this.focusNode,
        required this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: true,
      style: const TextStyle(color: Colors.white),
      // strutStyle: StrutStyle.disabled,
      inputFormatters: digitsOnly
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : inputFormatters,
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.top,
      maxLength: maxLength,
      focusNode: focusNode,
      onChanged: onChanged,
      textDirection: textDirection,
      keyboardType: keyboardType,
      onTap: onTap,
      maxLines: maxLines ?? 1,
      obscureText: isPassword,
      enableSuggestions: false,
      autocorrect: false,
      readOnly: readOnly,
      controller: controller,
      textAlign: textAlign,
      cursorColor: const Color(0xffEAEDF0),
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
        errorStyle: TextStyle(
            fontSize: 14.sp, color:Colors.white, fontWeight: FontWeight.w400),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        filled: true,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: const Color(0xFFEAEDF0), fontSize: 13.sp),
        hintText: str,
        fillColor: Colors.transparent,
      ),

      validator: validate,
      autovalidateMode: autovalidateMode,
    );
  }
}