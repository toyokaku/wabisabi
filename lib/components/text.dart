import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'wab_widget.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

class WabWarningText extends Text {
  WabWarningText({required String text})
      : super(text, style: TextStyle(color: Colors.red, fontSize: 15));
}

class WabTextFormField
    extends WabWidget<CupertinoTextFormFieldRow, Widget> {
  WabTextFormField({
    this.validator,
    this.callback,
    this.hint,
    this.hintText,
    this.obscureText = false,
    this.borderRadius = 8.0,
    this.padding = 15.0,
  });

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? callback;
  final String? hint;
  final String? hintText;
  final bool obscureText;
  final double borderRadius;
  final double padding;

  @override
  CupertinoTextFormFieldRow createCupertinoWidget(BuildContext context) =>
      CupertinoTextFormFieldRow(
        obscureText: obscureText,
        validator: validator,
        onChanged: callback,
        placeholder: hint ?? hintText,
        padding: EdgeInsets.all(padding),
        style: TextStyle(color: WabTheme.textColor),
        decoration: BoxDecoration(
          color: WabTheme.scratchColor,
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        ),
      );

  @override
  Widget createMaterialWidget(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          boxShadow: WabTheme.sunkenShadow,
        ),
        child: TextFormField(
          obscureText: obscureText,
          validator: validator,
          onChanged: callback,
          style: TextStyle(color: WabTheme.textColor),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: padding),
            fillColor: WabTheme.scratchColor,
            filled: true,
            hintText: hint ?? hintText,
            hintStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
          ),
        ),
      );
}

class WabNumberFormField extends WabWidget<CupertinoTextField, Widget> {
  WabNumberFormField(
      {this.value, this.callback, this.maxLength, this.labelText});

  final int? value;
  final ValueChanged<String>? callback;
  final int? maxLength;
  final String? labelText;

  @override
  CupertinoTextField createCupertinoWidget(BuildContext context) =>
      CupertinoTextField(
        controller: TextEditingController(text: value.toString()),
        onSubmitted: callback,
        placeholder: labelText,
        keyboardType: TextInputType.number,
        style: TextStyle(color: WabTheme.textColor),
        decoration: BoxDecoration(
          color: WabTheme.scratchColor,
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ],
      );

  @override
  Widget createMaterialWidget(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          boxShadow: WabTheme.sunkenShadow,
        ),
        child: TextField(
          controller: TextEditingController(text: value.toString()),
          onSubmitted: callback,
          style: TextStyle(color: WabTheme.textColor),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.7)),
            fillColor: WabTheme.scratchColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxLength),
          ],
        ),
      );
}

class WabSearchField extends WabWidget<CupertinoSearchTextField, Widget> {
  WabSearchField({
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.hintText = 'Search',
  });

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final String hintText;

  @override
  CupertinoSearchTextField createCupertinoWidget(BuildContext context) =>
      CupertinoSearchTextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        placeholder: hintText,
        backgroundColor: WabTheme.scratchColor,
        style: TextStyle(color: WabTheme.textColor),
        placeholderStyle:
            TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        padding: EdgeInsets.symmetric(vertical: 12),
      );

  @override
  Widget createMaterialWidget(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          boxShadow: WabTheme.sunkenShadow,
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyle(color: WabTheme.textColor),
          cursorColor: WabTheme.textColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: WabTheme.scratchColor,
            hintText: hintText,
            hintStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefixIcon: Icon(Icons.search, color: WabTheme.textColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
}
