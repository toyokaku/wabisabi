import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'utils/skr_theme.dart';
import 'utils/skr_widget.dart';

//Text

class SkrWarningText extends Text {
  SkrWarningText({required String text})
      : super(
          text,
          style: TextStyle(color: Colors.red, fontSize: 15),
        );
}

// Form

class SkrTextFormField
    extends SkrWidget<CupertinoTextFormFieldRow, TextFormField> {
  SkrTextFormField(
      {this.validator,
      this.callback,
      this.hint,
      this.obscureText = false,
      this.borderRadius = 8.0,
      this.padding = 15.0});

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? callback;
  final String? hint;
  final bool obscureText;
  final double borderRadius;
  final double padding;

  @override
  CupertinoTextFormFieldRow createCupertinoWidget(BuildContext context) =>
      CupertinoTextFormFieldRow(
        obscureText: obscureText,
        validator: validator,
        onChanged: callback,
        placeholder: hint,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(
            color: SkrTheme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      );

  @override
  TextFormField createMaterialWidget(BuildContext context) => TextFormField(
        obscureText: obscureText,
        validator: validator,
        onChanged: callback,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: padding),
          fillColor: SkrTheme.secondaryColor,
          filled: true,
          hintText: hint,
        ),
      );
}

class SkrNumberFormField extends SkrWidget<CupertinoTextField, TextField> {
  SkrNumberFormField(
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
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ],
      );

  @override
  TextField createMaterialWidget(BuildContext context) => TextField(
        controller: TextEditingController(text: value.toString()),
        onSubmitted: callback,
        decoration: InputDecoration(labelText: labelText),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ],
      );
}
