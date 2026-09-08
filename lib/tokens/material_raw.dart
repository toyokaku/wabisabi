// Raw material parameters — no Flutter dependency.
// material.dart wraps the color values in Color() for Flutter use.
// These feed the lib/materials/ painters (deckle edge, paper texture,
// wood grain, brush divider, ink wash).

// ---- 毛邊 deckle edge -------------------------------------------------
const double kDeckleRoughness       = 2.0;  // vertical-edge wobble amplitude px
const double kDeckleRoughnessPaper  = 2.2;  // paper panels — torn-edge feel
const double kDeckleRoughnessMetric = 1.8;  // metric panels — calmer edge
const double kDeckleRoughnessH      = 0.7;  // horizontal edges — much calmer
const int    kDeckleSeed            = 42;   // generic noise seed
const int    kDeckleSeedPaper       = 7;    // paper panel noise seed
const int    kDeckleSeedMetric      = 21;   // metric panel noise seed
const double kDeckleSideWidth       = 1.2;  // ink line width px
// Noise frequencies — looser than the RAG prototype (fewer waves per edge).
const double kDeckleFreq1 = 6.1;
const double kDeckleFreq2 = 17.3;
const double kDeckleFreq3 = 41.9;

// ---- 木紋 wood grain ---------------------------------------------------
const int kWoodBaseLight = 0xFFC9A96F;  // light wood base
const int kWoodDeepLight = 0xFF8F7343;  // light wood grain/knot
const int kWoodBaseDark  = 0xFF4A3A22;  // dark wood base
const int kWoodDeepDark  = 0xFF332716;  // dark wood grain/knot
const double kWoodGrainOpacityLight = 0.30;  // grain stroke alpha, light
const double kWoodGrainOpacityDark  = 0.40;  // grain stroke alpha, dark
const double kWoodKnotOpacity       = 0.22;  // knot ring alpha, both themes
const double kWoodEdgeLightOpacityLight = 0.22;  // top-edge highlight, light
const double kWoodEdgeLightOpacityDark  = 0.08;  // top-edge highlight, dark
const double kWoodSeed = 3.0;  // default grain wobble seed
// Denser grain than the RAG prototype: tighter pitch, finer stroke.
const double kWoodGrainSpacing = 3.5;  // grain line pitch px
const double kWoodGrainStroke  = 0.9;  // grain stroke width px
const double kWoodGrainStep    = 4.0;  // polyline sample step px
const int kWoodTextLight = 0xFF3A2E1C;  // text on light wood (dark timber)
const int kSealText = 0xFFFAF6EC;  // paper-white text on seal red
const double kSealShadowOpacity = 0.25;  // small contact shadow under a seal

// ---- 布紋 cloth weave（漢服材質）----------------------------------------
const int kClothBaseLight = 0xFF4A6670;  // 蓼藍 indigo-dyed cloth, light
const int kClothDeepLight = 0xFF3A525B;  // weave shadow, light
const int kClothBaseDark  = 0xFF2C3A41;  // cloth base, dark
const int kClothDeepDark  = 0xFF1F2B31;  // weave shadow, dark
const double kClothWeaveSpacing = 3.0;   // weave line pitch px — fine, dense
const double kClothWeaveOpacityLight = 0.10;  // weave alpha, light
const double kClothWeaveOpacityDark  = 0.14;  // weave alpha, dark

// ---- 玉石 jade ------------------------------------------------------------
const int kJadeBaseLight = 0xFFA8C0B2;  // 玉色 pale green base, light
const int kJadeDeepLight = 0xFF6E9182;  // jade depth, light
const int kJadeBaseDark  = 0xFF2E3A33;  // jade base, dark
const int kJadeDeepDark  = 0xFF1F2A24;  // jade depth, dark
const double kJadeSheenOpacityLight = 0.35;  // top sheen, light
const double kJadeSheenOpacityDark  = 0.12;  // top sheen, dark

// ---- 紙紋 paper texture -------------------------------------------------
// 宣紙/拓片手感——純色調明暗，無線條：實采茶經封面（晝）與碑拓（夜）。
// 晝：淡黃雲斑（ab1189 式）+ 茶經灰褐暗斑，落在暖白紙底上；
// 夜：拓片石光（青灰亮斑）+ 深陷影，落在墨底上。散點保留，作紙筋/石花。
const int kPaperTextureSeed = 99;  // fixed seed — rebuild-stable
const double kPaperDotOpacityLight   = 0.06;   // dot alpha, light
const double kPaperDotOpacityDark    = 0.06;   // dot alpha, dark — 拓片石花
const int kPaperDotTintLight   = 0xFF6B655B;  // dot tint light (grey-taupe, 不黃)
const int kPaperTintDark       = 0xFFFFFFFF;  // dot tint dark (white)

// 雲斑 mottle — the whole texture: large soft tonal blotches, no lines.
// 晝色實采：茶經 #9D8A79（暗斑）、ab1189 #F2E2C1→調淡（淡黃亮斑）。
// 夜色實采：拓片 #40433C（石光）、#12140F（陷影）。
const int kPaperMottleDeepLight = 0xFF9D8A79;  // 茶經暗斑, light
const int kPaperMottlePaleLight = 0xFFEBDCB6;  // 淡黃亮斑, light
const int kPaperMottleSheenDark = 0xFF40433C;  // 拓片石光, dark
const int kPaperMottleDeepDark  = 0xFF12140F;  // 拓片陷影, dark
const double kPaperMottleOpacityDeepLight = 0.14;  // 暗斑 alpha, light
const double kPaperMottleOpacityPaleLight = 0.13;  // 亮斑 alpha, light
const double kPaperMottleOpacitySheenDark = 0.16;  // 石光 alpha, dark
const double kPaperMottleOpacityDeepDark  = 0.20;  // 陷影 alpha, dark
const double kPaperMottleDensity = 0.8;  // blotches /万px², both themes (clamped 4–12)

// 散點密度 — dots per 10,000 px² of surface (area-proportional, so
// buttons stay as calm as panels). Dark = 拓片: sporadic but legible —
// sparse specks, not a field, not a void.
const double kPaperDotDensityLight   = 7.0;   // dots /万px², light
const double kPaperDotDensityDark    = 6.0;   // dots /万px², dark

// ---- 邊欄 rule frame（古籍版式）-------------------------------------------
// 單欄 single: 茶經封面式——一條單粗墨線，直邊方角。
// 雙欄 double: 外粗內細——外線粗、內線細，中間留隙。
// 細線只用於框內文字分隔（kRuleHairline），不作外框。
const double kRuleSingleWidth = 2.6;   // 單欄（單粗）線寬 px
const double kRuleOuterWidth  = 2.6;   // 雙欄外線寬 px（粗）
const double kRuleGap         = 3.5;   // 雙欄內外線間隙 px
const double kRuleInnerWidth  = 0.8;   // 雙欄內線寬 px（細）
const double kRuleOpacityLight = 0.85;  // frame ink alpha, light
const double kRuleOpacityDark  = 0.6;   // frame ink alpha, dark
const double kRuleHairline    = 0.6;   // 框內文字分隔細線 px

// ---- 印章鈕 stele seals（碑拓式：白文/朱文）--------------------------------
// 白文 baiwen — 實塊反字：晝=墨塊紙字，夜=紙塊墨字（拓片白印）。
// 朱文 zhuwen — 細框陽文：透明底，細墨框+墨字。
const int kBaiwenFaceLight = 0xFF322C24;  // 白文印面, light — 墨塊
const int kBaiwenTextLight = 0xFFF2ECDD;  // 白文印字, light — 紙色
const int kBaiwenFaceDark  = 0xFFD8D0BA;  // 白文印面, dark — 拓片白印
const int kBaiwenTextDark  = 0xFF1C1E19;  // 白文印字, dark — 墨
const double kZhuwenRuleWidth    = 1.2;   // 朱文細框 px
const double kZhuwenOpacityLight = 0.85;  // 朱文墨 alpha, light
const double kZhuwenOpacityDark  = 0.70;  // 朱文墨 alpha, dark

// ---- 環境背景 ambient page ground（scaffold TexturePainter）-----------------
// Light washi: 去黃走灰褐，暗光；dark lacquer 維持燭光金。
const int kWashiCloudWarm  = 0x07887A60;  // warm cloud, muted taupe (was A07040)
const int kWashiCloudCool  = 0x04808A8C;  // cool cloud, faint blue-grey
const int kWashiFiber      = 0xFF847866;  // fiber thread base (grey hemp, 不黃)
const int kWashiGrain      = 0x0F8A7C62;  // micro-dot grain (muted)
const int kLacquerVignette = 0x18000000;  // corner vignette, dark
const int kLacquerPatch    = 0x06C8A84A;  // warm amber patch, dark
const int kLacquerGrain    = 0x09C8A84A;  // fine grain, dark

// ---- 筆觸線 brush divider -------------------------------------------------
const double kBrushStrokeWidth1   = 2.4;  // main stroke width px
const double kBrushStrokeOpacity1 = 0.9;  // main stroke alpha
const double kBrushStrokeWidth2   = 1.0;  // echo stroke width px
const double kBrushStrokeOpacity2 = 0.4;  // echo stroke alpha
const double kBrushStrokeY1 = 5.0;   // main stroke baseline y
const double kBrushStrokeY2 = 8.5;   // echo stroke baseline y

// ---- 木作陰影 wood-panel shadows --------------------------------------------
const double kWoodShadowOpacityLight1 = 0.18;  // ambient, light
const double kWoodShadowOpacityLight2 = 0.08;  // contact, light
const double kWoodShadowOpacityDark1  = 0.40;  // ambient, dark
const double kWoodShadowOpacityDark2  = 0.20;  // contact, dark

// ---- 墨暈 ink wash -----------------------------------------------------------
// Three fixed blobs; opacity per blob per theme.
const double kInkWashOpacityLight1 = 0.09;
const double kInkWashOpacityLight2 = 0.06;
const double kInkWashOpacityLight3 = 0.05;
const double kInkWashOpacityDark1  = 0.05;
const double kInkWashOpacityDark2  = 0.04;
const double kInkWashOpacityDark3  = 0.03;
