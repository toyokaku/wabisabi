import 'package:flutter/material.dart';

import '../materials/rule_frame.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

OutlineInputBorder _wabRuleBorder(WabRuleKind kind, {bool focused = false}) {
  final color = focused
      ? WabTheme.textColor.withOpacity(.72)
      : WabTheme.lineColor.withOpacity(.82);
  return OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(
      color: color,
      width: WabRuleFrame.ruleWidth(kind),
    ),
  );
}

InputDecoration wabInputDecoration({
  String? hintText,
  Widget? prefixIcon,
  WabRuleKind kind = WabRuleKind.thin,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: WabTheme.mutedColor),
    prefixIcon: prefixIcon,
    filled: true,
    fillColor: WabTheme.scratchColor.withOpacity(.58),
    contentPadding: WAB_PADDING_ALL,
    enabledBorder: _wabRuleBorder(kind),
    focusedBorder: _wabRuleBorder(kind, focused: true),
    border: _wabRuleBorder(kind),
  );
}

/// Multi-line field uses the stronger single book rule.
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
        decoration: wabInputDecoration(
          hintText: hintText,
          kind: WabRuleKind.single,
        ),
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
            activeColor: WabTheme.textColor,
            checkColor: WabTheme.paperWhite,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(.8)),
            side: BorderSide(color: WabTheme.textColor, width: 1.8),
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
            activeColor: WabTheme.textColor,
            visualDensity: VisualDensity.compact,
            side: BorderSide(color: WabTheme.textColor, width: 1.8),
          ),
          if (label != null)
            Text(label!, style: TextStyle(color: WabTheme.textColor)),
        ],
      );
}

/// Horizontal switch using a rotated 古籍魚尾 / black-corner marker rather than
/// a modern pill thumb. The marker moves between the two ends of a fine rule.
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onChanged == null ? null : () => onChanged!(!value),
            child: SizedBox(
              width: 58,
              height: 25,
              child: CustomPaint(
                painter: _FishTailTrackPainter(
                  value: value ? 1.0 : 0.0,
                  enabled: onChanged != null,
                  binary: true,
                ),
              ),
            ),
          ),
          if (label != null) ...[
            const SizedBox(width: 5),
            Text(label!, style: TextStyle(color: WabTheme.textColor)),
          ],
        ],
      );
}

/// Slider/progress language derived from a horizontalized book-page 魚尾.
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

  double _fromDx(double dx, double width) {
    if (width <= 20) return min;
    final t = ((dx - 10) / (width - 20)).clamp(0.0, 1.0).toDouble();
    return min + (max - min) * t;
  }

  @override
  Widget build(BuildContext context) {
    final t = max == min
        ? 0.0
        : ((value - min) / (max - min)).clamp(0.0, 1.0).toDouble();
    return SizedBox(
      height: 27,
      child: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: onChanged == null
              ? null
              : (d) => onChanged!(_fromDx(d.localPosition.dx, constraints.maxWidth)),
          onHorizontalDragUpdate: onChanged == null
              ? null
              : (d) => onChanged!(_fromDx(d.localPosition.dx, constraints.maxWidth)),
          child: CustomPaint(
            painter: _FishTailTrackPainter(
              value: t,
              enabled: onChanged != null,
              binary: false,
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _FishTailTrackPainter extends CustomPainter {
  const _FishTailTrackPainter({
    required this.value,
    required this.enabled,
    required this.binary,
  });

  final double value;
  final bool enabled;
  final bool binary;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final ink = WabTheme.textColor.withOpacity(enabled ? .82 : .30);
    final line = WabTheme.lineColor.withOpacity(enabled ? .78 : .36);
    final y = size.height / 2;
    final left = 9.0;
    final right = size.width - 9.0;
    final t = value.clamp(0.0, 1.0).toDouble();
    final x = left + (right - left) * t;

    canvas.drawLine(
      Offset(left, y),
      Offset(right, y),
      Paint()
        ..color = line
        ..strokeWidth = .8,
    );
    if (!binary) {
      canvas.drawLine(
        Offset(left, y),
        Offset(x, y),
        Paint()
          ..color = ink.withOpacity(.48)
          ..strokeWidth = 1.25,
      );
    }

    final top = Path()
      ..moveTo(x - 6.5, y - 8)
      ..lineTo(x + 6.5, y - 8)
      ..lineTo(x, y - .9)
      ..close();
    final bottom = Path()
      ..moveTo(x - 6.5, y + 8)
      ..lineTo(x + 6.5, y + 8)
      ..lineTo(x, y + .9)
      ..close();
    canvas.drawPath(top, Paint()..color = ink);
    canvas.drawPath(bottom, Paint()..color = ink);

    if (binary) {
      final tickPaint = Paint()
        ..color = line
        ..strokeWidth = .8;
      canvas.drawLine(Offset(left, y - 4), Offset(left, y + 4), tickPaint);
      canvas.drawLine(Offset(right, y - 4), Offset(right, y + 4), tickPaint);
    }
  }

  @override
  bool shouldRepaint(_FishTailTrackPainter old) =>
      old.value != value || old.enabled != enabled || old.binary != binary;
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
            .map((e) => DropdownMenuItem<T>(value: e.key, child: Text(e.value)))
            .toList(),
        onChanged: onChanged,
        dropdownColor: WabTheme.surfaceColor,
        style: TextStyle(
          color: WabTheme.textColor,
          fontFamilyFallback: kWabKaiFallback,
        ),
        decoration: wabInputDecoration(hintText: hintText),
      );
}
