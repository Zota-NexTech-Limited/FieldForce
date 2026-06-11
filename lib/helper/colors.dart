import 'package:flutter/material.dart';

/// Centralised colour system for the app.
///
/// NOTE: Every original token name is preserved so existing screens keep
/// compiling unchanged. Values have been refreshed to a modern, professional
/// "Refined Blue" palette (Material 3 aligned). New semantic tokens are added
/// at the bottom for the modernised design system.
class COLORS {
  // ---------------------------------------------------------------------------
  // Brand / primary  (refined blue brand)
  // ---------------------------------------------------------------------------
  static Color primaryColor = const Color(0xff2563EB); // brand blue
  static Color onPrimaryColor = const Color(0xffFFFFFF);
  static Color secondaryColor = const Color(0xffDBEAFE); // soft blue tint
  static Color backgroundColor = const Color(0xffF4F7FB); // app surface bg

  // ---------------------------------------------------------------------------
  // Original tokens (values refined, names kept for compatibility)
  // ---------------------------------------------------------------------------
  static const Color textColor = Color(0xff0F172A); // slate-900
  static const Color black = Color(0xff0F172A);
  static const Color white = Color(0xffFFFFFF);
  static const Color cardBorder = Color(0xffE6EAF0);
  static const Color gray = Color(0xff94A3B8); // slate-400
  static const Color red = Color(0xffEF4444);
  static const Color green = Color(0xff16A34A);
  static const Color yellow = Color(0xffF59E0B);
  static const Color iconColor = Color(0xff334155); // slate-700
  static const Color hintTextColor = Color(0xff94A3B8);
  static const Color blueExtraLight = Color(0xffCED3DE);
  static const Color profileGrayColor = Color(0xff64748B);
  static const Color billingCardBorder = Color(0xffE6EAF0);

  static const Color grayFilterBackColor = Color(0xffF1F5F9);
  static const Color grayFilterTextColor = Color(0xff64748B);
  static const Color hintColor = Color(0xff94A3B8);

  // ---------------------------------------------------------------------------
  // Modern design-system tokens (new — additive, safe to adopt anywhere)
  // ---------------------------------------------------------------------------
  static const Color primaryDark = Color(0xff1D4ED8);
  static const Color primaryLight = Color(0xff60A5FA);
  static const Color primarySoft = Color(0xffEFF4FE); // tinted container

  static const Color scaffoldBg = Color(0xffF4F7FB);
  static const Color surface = Color(0xffFFFFFF);
  static const Color surfaceMuted = Color(0xffF8FAFC);
  static const Color surfaceVariant = Color(0xffF1F5F9);

  static const Color outline = Color(0xffE2E8F0);
  static const Color divider = Color(0xffEEF2F7);
  static const Color shadow = Color(0x14101828); // soft ambient shadow

  // Text scale
  static const Color textPrimary = Color(0xff0F172A); // slate-900
  static const Color textSecondary = Color(0xff475569); // slate-600
  static const Color textTertiary = Color(0xff94A3B8); // slate-400

  // Semantic state colours
  static const Color success = Color(0xff16A34A);
  static const Color successSoft = Color(0xffDCFCE7);
  static const Color warning = Color(0xffF59E0B);
  static const Color warningSoft = Color(0xffFEF3C7);
  static const Color danger = Color(0xffEF4444);
  static const Color dangerSoft = Color(0xffFEE2E2);
  static const Color info = Color(0xff2563EB);
  static const Color infoSoft = Color(0xffDBEAFE);
}
