import 'package:fieldsales/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Centralised Material 3 theme for the modernised "Refined Blue" design system.
///
/// This is purely presentational. It themes default widgets (AppBar, buttons,
/// inputs, cards, dialogs, sheets, snackbars, etc.) so every screen inherits a
/// consistent, modern look. Screens that set their own inline styles keep
/// working unchanged — the theme only fills in defaults.
class AppTheme {
  static const String _fontFamily = 'Inter';

  // Shared design tokens
  static const double radiusSm = 10;
  static const double radiusMd = 14;
  static const double radiusLg = 18;
  static const double radiusXl = 24;

  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: COLORS.primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: COLORS.primaryColor,
      onPrimary: COLORS.onPrimaryColor,
      primaryContainer: COLORS.primarySoft,
      onPrimaryContainer: COLORS.primaryDark,
      secondary: COLORS.primaryDark,
      surface: COLORS.surface,
      onSurface: COLORS.textPrimary,
      surfaceContainerHighest: COLORS.surfaceVariant,
      error: COLORS.danger,
      outline: COLORS.outline,
      outlineVariant: COLORS.divider,
      shadow: COLORS.shadow,
    );

    final TextTheme textTheme = _buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: COLORS.scaffoldBg,
      textTheme: textTheme,
      primaryColor: COLORS.primaryColor,
      dividerColor: COLORS.divider,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: COLORS.primaryColor,
        foregroundColor: COLORS.onPrimaryColor,
        elevation: 0,
        scrolledUnderElevation: 2,
        shadowColor: COLORS.shadow,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: COLORS.white,
        ),
        iconTheme: const IconThemeData(color: COLORS.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      cardTheme: CardThemeData(
        color: COLORS.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: COLORS.cardBorder),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: COLORS.primaryColor,
          foregroundColor: COLORS.onPrimaryColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: COLORS.primaryColor,
          foregroundColor: COLORS.onPrimaryColor,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: COLORS.primaryColor,
          side: const BorderSide(color: COLORS.outline),
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: COLORS.primaryColor,
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: COLORS.surfaceMuted,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.hintTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textSecondary,
          fontSize: 14,
        ),
        prefixIconColor: COLORS.textTertiary,
        suffixIconColor: COLORS.textTertiary,
        border: _inputBorder(COLORS.outline),
        enabledBorder: _inputBorder(COLORS.outline),
        focusedBorder: _inputBorder(COLORS.primaryColor, width: 1.5),
        errorBorder: _inputBorder(COLORS.danger),
        focusedErrorBorder: _inputBorder(COLORS.danger, width: 1.5),
        errorStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.danger,
          fontSize: 12,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: COLORS.surfaceVariant,
        selectedColor: COLORS.primarySoft,
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: COLORS.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textSecondary,
          fontSize: 14,
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: COLORS.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXl)),
        ),
        showDragHandle: true,
        dragHandleColor: COLORS.outline,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: COLORS.textPrimary,
        contentTextStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.white,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        actionTextColor: COLORS.primaryLight,
        elevation: 4,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: COLORS.surface,
        selectedItemColor: COLORS.primaryColor,
        unselectedItemColor: COLORS.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: COLORS.surface,
        indicatorColor: COLORS.primarySoft,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: COLORS.primaryColor,
        foregroundColor: COLORS.onPrimaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: COLORS.divider,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: COLORS.primaryColor,
        linearTrackColor: COLORS.surfaceVariant,
        circularTrackColor: COLORS.surfaceVariant,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? COLORS.white
              : COLORS.gray,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? COLORS.primaryColor
              : COLORS.surfaceVariant,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? COLORS.primaryColor
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(COLORS.white),
        side: const BorderSide(color: COLORS.gray, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? COLORS.primaryColor
              : COLORS.gray,
        ),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: COLORS.primaryColor,
        unselectedLabelColor: COLORS.textTertiary,
        indicatorColor: COLORS.primaryColor,
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: COLORS.iconColor,
        textColor: COLORS.textPrimary,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: COLORS.textPrimary,
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.white,
          fontSize: 12,
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontWeight: FontWeight.w700),
      titleLarge: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20),
      titleMedium: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16),
      titleSmall: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14),
      bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontSize: 15),
      bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textSecondary,
          fontSize: 14),
      bodySmall: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textTertiary,
          fontSize: 12),
      labelLarge: TextStyle(
          fontFamily: _fontFamily,
          color: COLORS.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14),
    );
  }
}
