import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'form.dart';
import 'wab_utils.dart';
import 'wab_widget.dart';
import '../materials/rule_frame.dart';
import '../theme/wab_theme.dart';

BoxDecoration _cupertinoFieldDecoration(WabRuleKind kind) => BoxDecoration(
      color: WabTheme.scratchColor.withOpacity(.58),
      border: Border.all(
        color: WabTheme.lineColor.withOpacity(.82),
        width: WabRuleFrame.ruleWidth(kind),
      ),
    );

class WabWarningText extends Text {
  WabWarningText({required String text})
      : super(text, style: const TextStyle(color: Colors.red, fontSize: 15));
}

/// Single-line text field uses the thin book rule (the inner rule of a double
/// frame). Multi-line fields use [WabRuleKind.single] in `form.dart`.
class WabTextFormField
    extends WabWidget<CupertinoTextFormFieldRow, Widget> {
  WabTextFormField({
    this.validator,
    this.callback,
    this.hint,
    this.hintText,
    this.obscureText = false,
    this.borderRadius = 0.0,
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
        decoration: _cupertinoFieldDecoration(WabRuleKind.thin),
      );

  @override
  Widget createMaterialWidget(BuildContext context) => TextFormField(
        obscureText: obscureText,
        validator: validator,
        onChanged: callback,
        style: TextStyle(color: WabTheme.textColor),
        decoration: wabInputDecoration(
          hintText: hint ?? hintText,
          kind: WabRuleKind.thin,
        ).copyWith(
          contentPadding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
        ),
      );
}

/// Owns its [TextEditingController] so the field keeps its text and caret
/// across rebuilds, and disposes it. A null [value] is an empty field, not the
/// string "null".
class WabNumberFormField extends StatefulWidget {
  const WabNumberFormField({
    super.key,
    this.value,
    this.callback,
    this.maxLength,
    this.labelText,
  });

  final int? value;
  final ValueChanged<String>? callback;
  final int? maxLength;
  final String? labelText;

  @override
  State<WabNumberFormField> createState() => _WabNumberFormFieldState();
}

class _WabNumberFormFieldState extends State<WabNumberFormField> {
  late final TextEditingController _controller =
      TextEditingController(text: _textFor(widget.value));

  static String _textFor(int? value) => value?.toString() ?? '';

  List<TextInputFormatter> get _formatters => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(widget.maxLength),
      ];

  @override
  void didUpdateWidget(WabNumberFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == oldWidget.value) return;
    final text = _textFor(widget.value);
    if (_controller.text != text) _controller.text = text;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      isIos() ? _buildCupertino(context) : _buildMaterial(context);

  Widget _buildCupertino(BuildContext context) => CupertinoTextField(
        controller: _controller,
        onSubmitted: widget.callback,
        placeholder: widget.labelText,
        keyboardType: TextInputType.number,
        style: TextStyle(color: WabTheme.textColor),
        decoration: _cupertinoFieldDecoration(WabRuleKind.thin),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        inputFormatters: _formatters,
      );

  Widget _buildMaterial(BuildContext context) => TextField(
        controller: _controller,
        onSubmitted: widget.callback,
        style: TextStyle(color: WabTheme.textColor),
        decoration: wabInputDecoration(
          hintText: widget.labelText,
          kind: WabRuleKind.thin,
        ).copyWith(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.7)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: _formatters,
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
        backgroundColor: WabTheme.scratchColor.withOpacity(.58),
        style: TextStyle(color: WabTheme.textColor),
        placeholderStyle:
            TextStyle(color: WabTheme.textColor.withOpacity(0.5)),
        borderRadius: BorderRadius.zero,
        padding: const EdgeInsets.symmetric(vertical: 12),
      );

  @override
  Widget createMaterialWidget(BuildContext context) => TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(color: WabTheme.textColor),
        cursorColor: WabTheme.textColor,
        decoration: wabInputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.search, color: WabTheme.textColor),
          kind: WabRuleKind.thin,
        ).copyWith(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
}
