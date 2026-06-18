import 'package:flutter/material.dart';

/// Wabi-Sabi inspired color palette — raw named colors, no widget dependency.
/// This is the single source of truth for all color values in the kit.
/// Theme files map these into ThemeData; components never reference this directly.
class WabiSabiColors {
  // Earthen tones
  static const clay    = Color(0xFF8B5E3C); // weathered clay
  static const stone   = Color(0xFF646464); // aged stone
  static const bamboo  = Color(0xFFBEA163); // sun-bleached bamboo
  static const elm     = Color(0xFFFFE1B1); // brightened elm wood

  // Natural accents
  static const moss      = Color(0xFF687F5F); // forest moss
  static const rust      = Color(0xFF9A3729); // oxidized metal
  static const indigoDye = Color(0xFF4A6670); // natural indigo dye
  static const pebble    = Color(0xFFE4C7B8); // light pebble stone

  // Neutral foundations
  static const rice     = Color(0xFFF3EDE4); // unbleached rice paper
  static const ash      = Color(0xFFD3CBC4); // wood ash
  static const charcoal = Color(0xFF2C2C2C); // burnt charcoal
  static const soil     = Color(0xFF8B734F); // mushy soil

  // Seasonal accents
  static const sakura    = Color(0xFFE8C0C0); // faded cherry blossom
  static const maple     = Color(0xFFC46D5E); // autumn maple
  static const persimmon = Color(0xFFDB786E); // persimmon fruit
  static const tea       = Color(0xFFB39F8F); // steeped green tea

  // Surface variations
  static const paper   = Color(0xFFF9F9FA); // handmade paper
  static const cedar   = Color(0xFF8E766C); // aged cedar wood
  static const ceramic = Color(0xFFE8E2DC); // crackled ceramic
  static const sand    = Color(0xFFCFD0D1); // dark sand
}

// Operational light theme palette (maps WabiSabiColors → semantic roles)
const Color WAB_LIGHT_BACKGROUND = Color(0xFFF4E9CD);
const Color WAB_LIGHT_SURFACE    = Color(0xFFF8F5EE);
const Color WAB_LIGHT_PRIMARY    = Color(0xFFFFFFFF);
const Color WAB_LIGHT_SECONDARY  = Color(0xFFE8E3D9);
const Color WAB_LIGHT_ACCENT     = Color(0xFF63BAF2);
const Color WAB_LIGHT_ON         = Color(0xFF8AD192);
const Color WAB_LIGHT_OFF        = Color(0xFFEEEEEE);
const Color WAB_LIGHT_TEXT       = Color(0xFF333333);
const Color WAB_LIGHT_WOODY      = Color(0xFFD8B87D);

// Operational dark theme palette
const Color WAB_DARK_BACKGROUND = Color(0xFF222222);
const Color WAB_DARK_SURFACE    = Color(0xFF2A2A2A);
const Color WAB_DARK_PRIMARY    = Color(0xFF333333);
const Color WAB_DARK_SECONDARY  = Color(0xFF444444);
const Color WAB_DARK_ACCENT     = Color(0xFFAD9E6C);
const Color WAB_DARK_ON         = Color(0xFF65B96C);
const Color WAB_DARK_OFF        = Color(0xFF444444);
const Color WAB_DARK_TEXT       = Color(0xFFE0E0E0);
const Color WAB_DARK_WOODY      = Color(0xFF3A352B);
