import 'package:flutter/widgets.dart';

/// Visual style for a single [InkDot]. Pure data — no semantics.
class InkDotStyle {
  const InkDotStyle({
    required this.color,
    this.borderColor,
    this.borderWidth = 0,
  });

  final Color color;
  final Color? borderColor;
  final double borderWidth;

  @override
  bool operator ==(Object other) =>
      other is InkDotStyle &&
      other.color == color &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth;

  @override
  int get hashCode => Object.hash(color, borderColor, borderWidth);
}

/// A single round ink dot rendered from a passed [InkDotStyle].
/// Dumb widget: it renders what it is told, nothing more.
class InkDot extends StatelessWidget {
  const InkDot({super.key, required this.style, this.size = 10});

  final InkDotStyle style;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: style.color,
        border: style.borderColor == null
            ? null
            : Border.all(color: style.borderColor!, width: style.borderWidth),
      ),
    );
  }
}

/// A generic `rows × cols` matrix of round dots.
///
/// Dumb widget: it takes a flat, row-major array of cell [states] and a
/// [styleOf] mapping from a state to an [InkDotStyle]. It carries no domain
/// semantics (no "week", "life", etc.) — consumers own that meaning.
class DotGrid<S> extends StatelessWidget {
  const DotGrid({
    super.key,
    required this.rows,
    required this.cols,
    required this.states,
    required this.styleOf,
    this.dotSize = 10,
    this.gap = 3,
  }) : assert(states.length == rows * cols,
            'states.length must equal rows * cols');

  final int rows;
  final int cols;

  /// Row-major cell states, length == rows * cols.
  final List<S> states;

  /// Maps a cell state to its dot style.
  final InkDotStyle Function(S state) styleOf;

  final double dotSize;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int r = 0; r < rows; r++)
          Padding(
            padding: EdgeInsets.only(bottom: r == rows - 1 ? 0 : gap),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int c = 0; c < cols; c++)
                  Padding(
                    padding: EdgeInsets.only(right: c == cols - 1 ? 0 : gap),
                    child: InkDot(
                      style: styleOf(states[r * cols + c]),
                      size: dotSize,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
