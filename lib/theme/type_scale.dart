/// The kit's type ladder.
///
/// Every font size in `lib/` comes from here, so the scale can be re-tuned in
/// one file instead of hunted through forty call sites.
///
/// It has thirteen rungs, which is too many — a ladder this fine is a record of
/// sizes chosen one at a time rather than a scale. Collapsing it is a design
/// decision, not a refactor, so the rungs are named as they stand and the
/// decision is noted in ARCHITECTURE.md.
///
/// Flutter already multiplies these by `MediaQuery.textScaler`, so they are the
/// size at a scale factor of 1. Anything that boxes text at a fixed height has
/// to cope with them growing.
abstract final class WabType {
  /// 夾註 — interlinear annotation. The densest label the kit draws.
  static const double annotation = 8;

  /// Caption under a specimen or a card's supporting line.
  static const double caption = 9;

  /// 腳註 — footnote weight; small print that is still prose.
  static const double footnote = 10;

  /// Badge and tag labels, banner subtitles.
  static const double gloss = 11;

  /// Secondary line in a header block.
  static const double note = 12;

  /// Dense titles inside small cards.
  static const double dense = 13;

  /// Body text. The default reading size.
  static const double body = 14;

  /// Body text that needs to carry a little more weight.
  static const double bodyLarge = 15;

  /// Control and navigation labels.
  static const double label = 16;

  /// 引首 — the lead line of a masthead.
  static const double lede = 17;

  /// Section and panel titles.
  static const double title = 18;

  /// Hero display text and seal faces.
  static const double display = 24;

  /// The brand mark itself.
  static const double brand = 31;
}
