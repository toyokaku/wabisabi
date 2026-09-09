import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

import 'golden1_showcase.dart';

void main() => runApp(const WabisabiExample());

class WabisabiExample extends StatefulWidget {
  const WabisabiExample({super.key});

  @override
  State<WabisabiExample> createState() => _WabisabiExampleState();
}

class _WabisabiExampleState extends State<WabisabiExample> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: WabTheme.materialTheme(lightTheme: !isDark),
      home: Golden1Showcase(
        isDark: isDark,
        onToggleTheme: () => setState(() => isDark = !isDark),
      ),
    );
  }
}
