import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

InputDecoration _wabInputDecoration({String? hintText, Widget? prefixIcon}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
    borderSide: BorderSide(color: WabTheme.lineColor),
  );
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: WabTheme.mutedColor),
    prefixIcon: prefixIcon,
    filled: true,
    fillColor: WabTheme.scratchColor,
    contentPadding: WAB_PADDING_ALL,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: BorderSide(color: WabTheme.textColor),
    ),
    border: border,
  );
}

/// Multi-line companion to [WabTextFormField].
class WabMultilineField extends StatelessWidget {
  const WabMultilineField({
    super.key,
    this.hintText,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 5,
  });

  final String? hintText;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextField(
        minLines: minLines,
        maxLines: maxLines,
        onChanged: onChanged,
        style: TextStyle(
          color: WabTheme.textColor,
          fontFamilyFallback: kWabKaiFallback,
        ),
        decoration: _wabInputDecoration(hintText: hintText),
      );
}

class WabCheckbox extends StatelessWidget {
  const WabCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: WabTheme.onColor,
            checkColor: WabTheme.paperWhite,
            side: BorderSide(color: WabTheme.textColor),
          ),
          if (label != null)
            Text(label!, style: TextStyle(color: WabTheme.textColor)),
        ],
      );
}

class WabRadio<T> extends StatelessWidget {
  const WabRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: WabTheme.onColor,
          ),
          if (label != null)
            Text(label!, style: TextStyle(color: WabTheme.textColor)),
        ],
      );
}

class WabSwitch extends StatelessWidget {
  const WabSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: WabTheme.paperWhite,
            activeTrackColor: WabTheme.onColor,
            inactiveThumbColor: WabTheme.primaryColor,
            inactiveTrackColor: WabTheme.offColor,
          ),
          if (label != null)
            Text(label!, style: TextStyle(color: WabTheme.textColor)),
        ],
      );
}

class WabSlider extends StatelessWidget {
  const WabSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) => Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
        activeColor: WabTheme.onColor,
        inactiveColor: WabTheme.offColor,
      );
}

class WabDropdown<T> extends StatelessWidget {
  const WabDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
        initialValue: value,
        items: items.entries
            .map((e) => DropdownMenuItem<T>(
                  value: e.key,
                  child: Text(e.value),
                ))
            .toList(),
        onChanged: onChanged,
        dropdownColor: WabTheme.surfaceColor,
        style: TextStyle(
          color: WabTheme.textColor,
          fontFamilyFallback: kWabKaiFallback,
        ),
        decoration: _wabInputDecoration(hintText: hintText),
      );
}
