import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: WabTheme.materialTheme(lightTheme: !isDark),
      home: Showcase(
        isDark: isDark,
        onToggleTheme: () => setState(() => isDark = !isDark),
      ),
    );
  }
}

/// A catalogue of every wabisabi widget. Top banner and left rail are kept
/// separate from the body; the body is a vertical scrolling list of widgets,
/// each labelled with its class name.
class Showcase extends StatefulWidget {
  const Showcase({super.key, required this.isDark, required this.onToggleTheme});
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  String _nav = 'WabNavItem (selected)';
  bool _toggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WabTheme.backgroundColor,
      body: Column(
        children: [
          _banner(),
          WabDivider(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _sidebar(),
                VerticalDivider(width: 1, color: WabTheme.secondaryColor),
                Expanded(child: _body()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- Top panel ----------------------------------------------------------

  Widget _banner() => WabBanner(
        title: 'WabBanner',
        subtitle: 'top banner',
        seal: _seal(),
        leading: Icon(Icons.menu, color: WabTheme.textColor),
        trailing: [
          const Spacer(flex: 3),
          Flexible(flex: 2, child: WabSearchField(hintText: 'WabSearchField')),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'toggle theme',
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              color: WabTheme.textColor,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      );

  Widget _seal() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: const BoxDecoration(color: Color(0xFF9A3729)),
        child: const Text('seal',
            style: TextStyle(color: Colors.white, fontSize: 10)),
      );

  // ---- Left panel ---------------------------------------------------------

  Widget _sidebar() => WabSidebar(
        children: [
          const WabProfileHeader(name: 'WabProfileHeader', subtitle: 'profile'),
          const SizedBox(height: 24),
          for (final label in const ['WabNavItem', 'WabNavItem (selected)'])
            WabNavItem(
              label: label,
              selected: _nav == label,
              onTap: () => setState(() => _nav = label),
            ),
        ],
      );

  // ---- Body: scrolling widget list ---------------------------------------

  Widget _body() => ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _demo('WabPanel', WabPanel(
            title: 'WabPanel',
            trailing: const WabStatusBadge('trailing', kind: WabBadgeKind.neutral),
            child: const Text('A titled section surface.'),
          )),
          _demo('WabContainer', WabContainer(child: const Text('WabContainer'))),
          _demo('WabLiteContainer',
              WabLiteContainer(child: const Text('WabLiteContainer'))),
          _demo('WabDivider', WabDivider()),
          _demo('WabElevatedButton', Column(children: [
            WabElevatedButton(
                text: const Text('WabElevatedButton'), callback: () {}),
            const SizedBox(height: 12),
            WabElevatedButton(
              text: const Text('with icon + chevron'),
              icon: const Icon(Icons.settings, size: 18),
              showChevron: true,
              callback: () {},
            ),
          ])),
          _demo('WabTextButton',
              WabTextButton(text: const Text('WabTextButton'), callback: () {})),
          _demo('WabIconButton', Row(children: [
            WabIconButton(
                icon: const Icon(Icons.favorite),
                label: const Text('WabIconButton'),
                callback: () {}),
            const SizedBox(width: 16),
            WabIconButton(icon: const Icon(Icons.search), callback: () {}),
          ])),
          _demo('WabToggleButton', Row(children: [
            Expanded(
              child: WabToggleButton(
                text: const Text('ON'),
                isOn: _toggle,
                callback: () => setState(() => _toggle = true),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: WabToggleButton(
                text: const Text('OFF'),
                isOn: !_toggle,
                callback: () => setState(() => _toggle = false),
              ),
            ),
          ])),
          _demo('WabStatusBadge', Wrap(spacing: 12, children: const [
            WabStatusBadge('progress', kind: WabBadgeKind.progress),
            WabStatusBadge('done', kind: WabBadgeKind.done),
            WabStatusBadge('neutral', kind: WabBadgeKind.neutral),
          ])),
          _demo('WabStarRating', Row(children: const [
            WabStarRating(rating: 3),
            SizedBox(width: 24),
            WabStarRating(rating: 5),
          ])),
          _demo('WabCollectionCard', Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: WabCollectionCard(
                  icon: Icon(Icons.emoji_food_beverage,
                      size: 40, color: WabTheme.textColor),
                  title: 'WabCollectionCard',
                  description: 'A collection card with an action.',
                  buttonLabel: 'action',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: WabCollectionCard(
                  icon: Icon(Icons.local_cafe,
                      size: 40, color: WabTheme.textColor),
                  title: 'highlighted',
                  description: 'Same card, filled action button.',
                  buttonLabel: 'action',
                  highlighted: true,
                  onPressed: () {},
                ),
              ),
            ],
          )),
          _demo('WabTextFormField',
              WabTextFormField(hintText: 'WabTextFormField')),
          _demo('WabNumberFormField',
              WabNumberFormField(value: 0, labelText: 'WabNumberFormField')),
          _demo('InkDot', Row(children: [
            for (final (label, style) in [
              ('flat', InkDotStyle(color: WabTheme.secondaryColor)),
              (
                'ringed',
                InkDotStyle(
                  color: WabTheme.textColor,
                  borderColor: WabTheme.accentColor,
                  borderWidth: 2,
                )
              ),
              ('accent', InkDotStyle(color: WabTheme.progressColor)),
            ]) ...[
              InkDot(style: style, size: 14),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: WabTheme.mutedColor, fontSize: 12)),
              const SizedBox(width: 20),
            ],
          ])),
          _demo(
            'DotGrid',
            DotGrid<int>(
              rows: 5,
              cols: 26,
              states: List.generate(
                  130, (i) => i < 58 ? 0 : (i == 58 ? 1 : (i % 19 == 0 ? 2 : 3))),
              styleOf: (s) => switch (s) {
                0 => InkDotStyle(color: WabTheme.secondaryColor),
                1 => InkDotStyle(
                    color: WabTheme.textColor,
                    borderColor: WabTheme.accentColor,
                    borderWidth: 2,
                  ),
                2 => InkDotStyle(color: WabTheme.progressColor),
                _ => InkDotStyle(color: WabTheme.offColor.withOpacity(0.45)),
              },
              dotSize: 11,
              gap: 4,
            ),
          ),
        ],
      );

  Widget _demo(String name, Widget child) => Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      );
}
