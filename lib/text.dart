import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'utils/wab_theme.dart';
import 'utils/wab_widget.dart';
import 'const.dart';

//Text

class WabWarningText extends Text {
  WabWarningText({required String text})
      : super(
        text,
          style: TextStyle(color: Colors.red, fontSize: 15),
        );
}

// Form

class WabTextFormField
    extends WabWidget<CupertinoTextFormFieldRow, TextFormField> {
  WabTextFormField(
      {this.validator,
      this.callback,
      this.hint,
      this.hintText,
      this.obscureText = false,
      this.borderRadius = 8.0,
      this.padding = 15.0});

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
        decoration: BoxDecoration(
          color: WabTheme.woodyColor,
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        ),
        style: TextStyle(color: WabTheme.textColor),
      );

  @override
  TextFormField createMaterialWidget(BuildContext context) => TextFormField(
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
          fillColor: WabTheme.woodyColor,
          filled: true,
          hintText: hint ?? hintText,
          hintStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
        ),
      );
}

class WabNumberFormField extends WabWidget<CupertinoTextField, TextField> {
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
          color: WabTheme.woodyColor,
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ],
      );

  @override
  TextField createMaterialWidget(BuildContext context) => TextField(
        controller: TextEditingController(text: value.toString()),
        onSubmitted: callback,
        style: TextStyle(color: WabTheme.textColor),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.7)),
          fillColor: WabTheme.woodyColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ],
      );
}

class WabSearchField extends WabWidget<CupertinoSearchTextField, TextField> {
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
  CupertinoSearchTextField createCupertinoWidget(BuildContext context) {
    return CupertinoSearchTextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      placeholder: hintText,
      backgroundColor: WabTheme.woodyColor,
      style: TextStyle(color: WabTheme.textColor),
      placeholderStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
      padding: EdgeInsets.symmetric(vertical: 12),
    );
  }

  @override
  TextField createMaterialWidget(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: WabTheme.woodyColor,
        hintText: hintText,
        hintStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
      style: TextStyle(color: WabTheme.textColor),
      cursorColor: WabTheme.textColor,
    );
  }
}
