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

// Operational light theme palette (semantic roles) — warm tan desk + cream panels
const int kLightBackground = 0xFFCBB088;  // warm tan "desk"
const int kLightSurface    = 0xFFF5EEDD;  // cream panel surface
const int kLightPrimary    = 0xFFF9F3E6;  // lighter card bg
const int kLightSecondary  = 0xFFDFD2B6;  // warm borders / dividers
const int kLightAccent     = 0xFFB07D2B;  // gold (nav selected, headers accent)
const int kLightOn         = 0xFF6E8B4A;  // sage green — "完成" / success
const int kLightOff        = 0xFFD8CBB0;  // warm inactive
const int kLightText       = 0xFF3A2E1E;  // ink brown
const int kLightWoody      = 0xFFC49A4E;  // amber — buttons / input fills
const int kLightProgress   = 0xFF3E7CA0;  // steel blue — "進行中" badge

// Operational dark theme palette — deep navy-charcoal + gold accents
const int kDarkBackground = 0xFF0F1820;  // deep navy-charcoal app surface
const int kDarkSurface    = 0xFF1B2A35;  // panel surface
const int kDarkPrimary    = 0xFF16242E;  // card bg (slightly darker than panel)
const int kDarkSecondary  = 0xFF31424E;  // borders / dividers
const int kDarkAccent     = 0xFFC9A24A;  // rich gold (nav selected, stars, headers)
const int kDarkOn         = 0xFFB98A3C;  // amber — "完成" / success
const int kDarkOff        = 0xFF31424E;  // inactive
const int kDarkText       = 0xFFE6D8B8;  // warm cream
const int kDarkWoody      = 0xFF8A6A38;  // bronze — buttons / input fills
const int kDarkProgress   = 0xFF2E6B8A;  // steel blue — "進行中" badge
