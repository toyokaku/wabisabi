// Raw color values as ARGB ints — no Flutter dependency.
// palette.dart wraps these in Color() for Flutter use.
// tool/export_tokens.dart reads these to generate web/quarto SCSS.

// WabiSabiColors — named palette (the "Nord" layer)
const int kClay      = 0xFF8B5E3C;
const int kStone     = 0xFF646464;
const int kBamboo    = 0xFFBEA163;
const int kElm       = 0xFFFFE1B1;
const int kMoss      = 0xFF687F5F;
const int kRust      = 0xFF9A3729;
const int kIndigoDye = 0xFF4A6670;
const int kPebble    = 0xFFE4C7B8;
const int kRice      = 0xFFF3EDE4;
const int kAsh       = 0xFFD3CBC4;
const int kCharcoal  = 0xFF2C2C2C;
const int kSoil      = 0xFF8B734F;
const int kSakura    = 0xFFE8C0C0;
const int kMaple     = 0xFFC46D5E;
const int kPersimmon = 0xFFDB786E;
const int kTea       = 0xFFB39F8F;
const int kPaper     = 0xFFF9F9FA;
const int kCedar     = 0xFF8E766C;
const int kCeramic   = 0xFFE8E2DC;
const int kSand      = 0xFFCFD0D1;

// Operational light theme palette (semantic roles)
const int kLightBackground = 0xFFF2E8CC;  // warm parchment
const int kLightSurface    = 0xFFF7F2E5;  // card surface, slightly lighter parchment
const int kLightPrimary    = 0xFFFBF7EE;  // barely-warm white (nav/card bg)
const int kLightSecondary  = 0xFFE2D9C5;  // warm dividers / secondary surfaces
const int kLightAccent     = 0xFF5E8C96;  // muted teal (nav selected, links)
const int kLightOn         = 0xFF7AA882;  // muted sage (active/success)
const int kLightOff        = 0xFFDDD5C5;  // warm inactive gray
const int kLightText       = 0xFF2A2318;  // deep ink
const int kLightWoody      = 0xFFCFAB72;  // amber — input fills, button bg

// Operational dark theme palette
const int kDarkBackground = 0xFF1C1814;  // warm brownish-black (not cold gray)
const int kDarkSurface    = 0xFF262018;  // warm dark card surface
const int kDarkPrimary    = 0xFF2E291E;  // warm dark nav/card bg
const int kDarkSecondary  = 0xFF3C3626;  // warm dividers
const int kDarkAccent     = 0xFFC8A84A;  // rich gold (nav selected, active)
const int kDarkOn         = 0xFF6DA878;  // muted sage (success)
const int kDarkOff        = 0xFF3C3626;  // same as secondary (inactive)
const int kDarkText       = 0xFFCEC0A0;  // warm cream
const int kDarkWoody      = 0xFF362F1F;  // dark amber — input fills
