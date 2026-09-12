import 'package:flutter/material.dart';
import 'material_raw.dart';

/// Material parameters for Flutter. Source of truth is material_raw.dart.
/// The materials/ painters consume these; components never reference them directly.

// ---- 毛邊 deckle edge ----
const double WAB_DECKLE_ROUGHNESS        = kDeckleRoughness;
const double WAB_DECKLE_ROUGHNESS_PAPER  = kDeckleRoughnessPaper;
const double WAB_DECKLE_ROUGHNESS_METRIC = kDeckleRoughnessMetric;
const double WAB_DECKLE_ROUGHNESS_H      = kDeckleRoughnessH;
const int    WAB_DECKLE_SEED             = kDeckleSeed;
const int    WAB_DECKLE_SEED_PAPER       = kDeckleSeedPaper;
const int    WAB_DECKLE_SEED_METRIC      = kDeckleSeedMetric;
const double WAB_DECKLE_SIDE_WIDTH       = kDeckleSideWidth;
const double WAB_DECKLE_FREQ1            = kDeckleFreq1;
const double WAB_DECKLE_FREQ2            = kDeckleFreq2;
const double WAB_DECKLE_FREQ3            = kDeckleFreq3;

// ---- 木紋 wood grain ----
const Color WAB_WOOD_BASE_LIGHT = Color(kWoodBaseLight);
const Color WAB_WOOD_DEEP_LIGHT = Color(kWoodDeepLight);
const Color WAB_WOOD_BASE_DARK  = Color(kWoodBaseDark);
const Color WAB_WOOD_DEEP_DARK  = Color(kWoodDeepDark);
const double WAB_WOOD_GRAIN_OPACITY_LIGHT = kWoodGrainOpacityLight;
const double WAB_WOOD_GRAIN_OPACITY_DARK  = kWoodGrainOpacityDark;
const double WAB_WOOD_KNOT_OPACITY        = kWoodKnotOpacity;
const double WAB_WOOD_EDGE_OPACITY_LIGHT  = kWoodEdgeLightOpacityLight;
const double WAB_WOOD_EDGE_OPACITY_DARK   = kWoodEdgeLightOpacityDark;
const double WAB_WOOD_SEED = kWoodSeed;
const double WAB_WOOD_GRAIN_SPACING = kWoodGrainSpacing;
const double WAB_WOOD_GRAIN_STROKE  = kWoodGrainStroke;
const double WAB_WOOD_GRAIN_STEP    = kWoodGrainStep;
const Color WAB_WOOD_TEXT_LIGHT = Color(kWoodTextLight);
const Color WAB_SEAL_TEXT = Color(kSealText);
const double WAB_SEAL_SHADOW_OPACITY = kSealShadowOpacity;

// ---- 布紋 cloth weave ----
const Color WAB_CLOTH_BASE_LIGHT = Color(kClothBaseLight);
const Color WAB_CLOTH_DEEP_LIGHT = Color(kClothDeepLight);
const Color WAB_CLOTH_BASE_DARK  = Color(kClothBaseDark);
const Color WAB_CLOTH_DEEP_DARK  = Color(kClothDeepDark);
const double WAB_CLOTH_WEAVE_SPACING        = kClothWeaveSpacing;
const double WAB_CLOTH_WEAVE_OPACITY_LIGHT  = kClothWeaveOpacityLight;
const double WAB_CLOTH_WEAVE_OPACITY_DARK   = kClothWeaveOpacityDark;

// ---- 玉石 jade ----
const Color WAB_JADE_BASE_LIGHT = Color(kJadeBaseLight);
const Color WAB_JADE_DEEP_LIGHT = Color(kJadeDeepLight);
const Color WAB_JADE_BASE_DARK  = Color(kJadeBaseDark);
const Color WAB_JADE_DEEP_DARK  = Color(kJadeDeepDark);
const double WAB_JADE_SHEEN_OPACITY_LIGHT = kJadeSheenOpacityLight;
const double WAB_JADE_SHEEN_OPACITY_DARK  = kJadeSheenOpacityDark;

// ---- 紙紋 paper texture ----
const int WAB_PAPER_TEXTURE_SEED = kPaperTextureSeed;
const double WAB_PAPER_DOT_OPACITY_LIGHT   = kPaperDotOpacityLight;
const double WAB_PAPER_DOT_OPACITY_DARK    = kPaperDotOpacityDark;
const Color WAB_PAPER_DOT_TINT_LIGHT   = Color(kPaperDotTintLight);
const Color WAB_PAPER_TINT_DARK        = Color(kPaperTintDark);
const double WAB_PAPER_DOT_DENSITY_LIGHT   = kPaperDotDensityLight;
const double WAB_PAPER_DOT_DENSITY_DARK    = kPaperDotDensityDark;
const Color WAB_PAPER_MOTTLE_DEEP_LIGHT = Color(kPaperMottleDeepLight);
const Color WAB_PAPER_MOTTLE_PALE_LIGHT = Color(kPaperMottlePaleLight);
const Color WAB_PAPER_MOTTLE_SHEEN_DARK = Color(kPaperMottleSheenDark);
const Color WAB_PAPER_MOTTLE_DEEP_DARK  = Color(kPaperMottleDeepDark);
const double WAB_PAPER_MOTTLE_OPACITY_DEEP_LIGHT = kPaperMottleOpacityDeepLight;
const double WAB_PAPER_MOTTLE_OPACITY_PALE_LIGHT = kPaperMottleOpacityPaleLight;
const double WAB_PAPER_MOTTLE_OPACITY_SHEEN_DARK = kPaperMottleOpacitySheenDark;
const double WAB_PAPER_MOTTLE_OPACITY_DEEP_DARK  = kPaperMottleOpacityDeepDark;
const double WAB_PAPER_MOTTLE_DENSITY = kPaperMottleDensity;

// ---- 邊欄 rule frame ----
const double WAB_RULE_SINGLE_WIDTH = kRuleSingleWidth;
const double WAB_RULE_OUTER_WIDTH  = kRuleOuterWidth;
const double WAB_RULE_GAP          = kRuleGap;
const double WAB_RULE_INNER_WIDTH  = kRuleInnerWidth;
const double WAB_RULE_OPACITY_LIGHT = kRuleOpacityLight;
const double WAB_RULE_OPACITY_DARK  = kRuleOpacityDark;
const double WAB_RULE_HAIRLINE     = kRuleHairline;

// ---- 印章鈕 stele seals ----
const Color WAB_BAIWEN_FACE_LIGHT = Color(kBaiwenFaceLight);
const Color WAB_BAIWEN_TEXT_LIGHT = Color(kBaiwenTextLight);
const Color WAB_BAIWEN_FACE_DARK  = Color(kBaiwenFaceDark);
const Color WAB_BAIWEN_TEXT_DARK  = Color(kBaiwenTextDark);
const double WAB_ZHUWEN_RULE_WIDTH    = kZhuwenRuleWidth;
const double WAB_ZHUWEN_OPACITY_LIGHT = kZhuwenOpacityLight;
const double WAB_ZHUWEN_OPACITY_DARK  = kZhuwenOpacityDark;

// ---- 環境背景 ambient page ground ----
const Color WAB_WASHI_CLOUD_WARM = Color(kWashiCloudWarm);
const Color WAB_WASHI_CLOUD_COOL = Color(kWashiCloudCool);
const Color WAB_WASHI_FIBER      = Color(kWashiFiber);
const Color WAB_WASHI_GRAIN      = Color(kWashiGrain);
const Color WAB_LACQUER_VIGNETTE = Color(kLacquerVignette);
const Color WAB_LACQUER_PATCH    = Color(kLacquerPatch);
const Color WAB_LACQUER_GRAIN    = Color(kLacquerGrain);

// ---- 筆觸線 brush divider ----
const double WAB_BRUSH_STROKE_WIDTH1   = kBrushStrokeWidth1;
const double WAB_BRUSH_STROKE_OPACITY1 = kBrushStrokeOpacity1;
const double WAB_BRUSH_STROKE_WIDTH2   = kBrushStrokeWidth2;
const double WAB_BRUSH_STROKE_OPACITY2 = kBrushStrokeOpacity2;
const double WAB_BRUSH_STROKE_Y1 = kBrushStrokeY1;
const double WAB_BRUSH_STROKE_Y2 = kBrushStrokeY2;

// ---- 木作陰影 wood-panel shadows ----
const double WAB_WOOD_SHADOW_OPACITY_LIGHT1 = kWoodShadowOpacityLight1;
const double WAB_WOOD_SHADOW_OPACITY_LIGHT2 = kWoodShadowOpacityLight2;
const double WAB_WOOD_SHADOW_OPACITY_DARK1  = kWoodShadowOpacityDark1;
const double WAB_WOOD_SHADOW_OPACITY_DARK2  = kWoodShadowOpacityDark2;

// ---- 墨暈 ink wash ----
const double WAB_INK_WASH_OPACITY_LIGHT1 = kInkWashOpacityLight1;
const double WAB_INK_WASH_OPACITY_LIGHT2 = kInkWashOpacityLight2;
const double WAB_INK_WASH_OPACITY_LIGHT3 = kInkWashOpacityLight3;
const double WAB_INK_WASH_OPACITY_DARK1  = kInkWashOpacityDark1;
const double WAB_INK_WASH_OPACITY_DARK2  = kInkWashOpacityDark2;
const double WAB_INK_WASH_OPACITY_DARK3  = kInkWashOpacityDark3;
