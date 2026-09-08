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

// Flat "washi" set — for flat, paper-like surfaces (e.g. dot matrices)
const int kWashi     = 0xFFF4F3EF;  // washi paper white
const int kMist      = 0xFFECEBE7;  // faint base grey
const int kDeadwood  = 0xFFD8D8D3;  // dead-wood grey (hairline borders)
const int kInk       = 0xFF1A1A1A;  // ink black
const int kFrost     = 0xFF88C0D0;  // frost blue (Nord accent)

// Operational light theme palette (semantic roles) — 宣紙暖白 (washi warm white)
const int kLightBackground = 0xFFEDE8DE;  // warm paper app surface
const int kLightSurface    = 0xFFF4F1E9;  // warm panel surface
const int kLightPrimary    = 0xFFFAF8F2;  // near-white card bg
const int kLightSecondary  = 0xFFD7D3CB;  // grey borders / dividers
const int kLightAccent     = 0xFFB08A3A;  // muted gold — stars / selected border
const int kLightMuted      = 0xFF6E6A62;  // grey — captions / secondary text
const int kLightOn         = 0xFF6E8B4A;  // sage green — success
const int kLightOff        = 0xFFD8D4CC;  // inactive
const int kLightText       = 0xFF2E2A24;  // near-black ink
const int kLightWoody      = 0xFFD9C089;  // light wood — buttons
const int kLightScratch    = 0xFFE7E2D6;  // warm neutral — sunken inputs (≠ buttons)
const int kLightProgress   = 0xFF3E7CA0;  // steel blue — progress badge

// Operational dark theme palette — 燈下觀墨 (ink by lamplight, warm low light)
const int kDarkBackground = 0xFF171512;  // warm near-black app surface
const int kDarkSurface    = 0xFF201D18;  // panel surface
const int kDarkPrimary    = 0xFF27241E;  // card bg (slightly lighter than panel)
const int kDarkSecondary  = 0xFF373A3D;  // borders / dividers
const int kDarkAccent     = 0xFFC2A05C;  // 燭光金 candlelight gold — stars / selected border
const int kDarkMuted      = 0xFF9A9384;  // warm grey — captions / secondary text
const int kDarkOn         = 0xFFB98A3C;  // amber — success
const int kDarkOff        = 0xFF373A3D;  // inactive
const int kDarkText       = 0xFFE6DFCE;  // soft warm paper-white
const int kDarkWoody      = 0xFF4A3A22;  // dark wood — buttons
const int kDarkScratch    = 0xFF2A271F;  // warm dark — sunken inputs (≠ buttons)
const int kDarkProgress   = 0xFF5E8CA8;  // steel blue — progress badge

// Supplementary operational colors — light theme
const int kPaperWhite = 0xFFFBFBF9;  // near-white card face (fey surface)
const int kMutedLight = 0xFF8C8C86;  // lighter muted step (fey captions)

// 夜紙 night paper — paper-material faces under 燈下觀墨
const int kDarkPaper = 0xFF2A2620;  // warm dark paper — card face on ink ground

// 朱砂 seal red — stamped accents, one per theme
const int kSealLight = 0xFF9A3729;  // 釉裏紅 underglaze red
const int kSealDark  = 0xFFB04A38;  // brighter seal for dark surfaces

// 淡墨 hairline — semi-transparent ink line, one per theme (ARGB: alpha kept)
const int kLineLight = 0x475A5242;  // ink line on paper, 28% alpha
const int kLineDark  = 0x2EE6DFCE;  // paper line on ink, 18% alpha
