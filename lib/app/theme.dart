import 'package:flutter/material.dart';

const ghibliBackground = Color(0xFF020A08);
const ghibliBackgroundSoft = Color(0xFF06110E);
const ghibliSurface = Color(0xFF0B1712);
const ghibliSurfaceRaised = Color(0xFF10231A);
const ghibliSurfaceHigh = Color(0xFF193225);
const ghibliIvory = Color(0xFFF4ECD9);
const ghibliMutedText = Color(0xFFB9C4B5);
const ghibliPaleGreen = Color(0xFFCFEFA5);
const ghibliDeepGreen = Color(0xFF25381B);
const ghibliDivider = Color(0xFF294239);
const ghibliStarGold = Color(0xFFE9B84F);

const ghibliRadius = 8.0;

ThemeData buildAppTheme() {
  final colorScheme =
      ColorScheme.fromSeed(
        seedColor: ghibliPaleGreen,
        brightness: Brightness.dark,
      ).copyWith(
        primary: ghibliPaleGreen,
        onPrimary: ghibliBackground,
        primaryContainer: ghibliDeepGreen,
        onPrimaryContainer: const Color(0xFFE8FAC3),
        secondary: const Color(0xFF8DBCA3),
        onSecondary: ghibliBackground,
        surface: ghibliSurface,
        surfaceContainerLowest: ghibliBackground,
        surfaceContainerLow: ghibliBackgroundSoft,
        surfaceContainer: ghibliSurface,
        surfaceContainerHigh: ghibliSurfaceRaised,
        surfaceContainerHighest: ghibliSurfaceHigh,
        onSurface: ghibliIvory,
        onSurfaceVariant: ghibliMutedText,
        outline: const Color(0xFF5C7568),
        outlineVariant: ghibliDivider,
        error: const Color(0xFFFFB4A9),
        onError: ghibliBackground,
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: ghibliBackground,
    dividerColor: ghibliDivider,
    textTheme: _buildTextTheme(colorScheme),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: ghibliBackground,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: ghibliIvory,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainer,
      surfaceTintColor: colorScheme.primary.withValues(alpha: 0.04),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.42),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ghibliRadius),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: colorScheme.surfaceContainerHigh,
      selectedColor: colorScheme.primaryContainer,
      checkmarkColor: colorScheme.onPrimaryContainer,
      labelStyle: TextStyle(color: colorScheme.onSurface),
      secondaryLabelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
      side: BorderSide(color: colorScheme.outlineVariant),
    ),
    dividerTheme: const DividerThemeData(
      color: ghibliDivider,
      space: 24,
      thickness: 1,
    ),
    iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHigh,
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      prefixIconColor: colorScheme.onSurfaceVariant,
      suffixIconColor: colorScheme.onSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ghibliRadius),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ghibliRadius),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ghibliRadius),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ghibliBackgroundSoft,
      indicatorColor: colorScheme.primaryContainer,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withValues(alpha: 0.42),
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        return TextStyle(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        );
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ghibliRadius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.7)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ghibliRadius),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ghibliRadius),
        ),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      contentTextStyle: TextStyle(color: colorScheme.onSurface),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ghibliRadius),
      ),
    ),
  );
}

TextTheme _buildTextTheme(ColorScheme colorScheme) {
  const base = TextTheme(
    headlineMedium: TextStyle(fontSize: 28, letterSpacing: 0),
    titleLarge: TextStyle(fontSize: 22, letterSpacing: 0),
    titleMedium: TextStyle(fontSize: 16, letterSpacing: 0),
    labelLarge: TextStyle(fontSize: 14, letterSpacing: 0),
    bodyLarge: TextStyle(fontSize: 16, letterSpacing: 0),
    bodyMedium: TextStyle(fontSize: 14, letterSpacing: 0),
    bodySmall: TextStyle(fontSize: 12, letterSpacing: 0),
  );

  return base.apply(
    bodyColor: colorScheme.onSurface,
    displayColor: colorScheme.onSurface,
  );
}
