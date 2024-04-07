import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/app_colors_constants.dart';
import 'package:flutter_application_1/consts/assets_constants.dart';

ThemeData buildThemeData() {
  final defaultLightColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.red, brightness: Brightness.light);

  final ThemeData theme = ThemeData(
      colorScheme: defaultLightColorScheme,
      scaffoldBackgroundColor: AppColors.pokedexColor,
      useMaterial3: true,
      fontFamily: AssetsConsts.notoSantsFont,
      appBarTheme: const AppBarTheme(
          color: AppColors.pokedexColor,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 72),
        displayMedium: TextStyle(fontSize: 45),
        displaySmall: TextStyle(fontSize: 36),
        headlineLarge: TextStyle(fontSize: 32),
        headlineMedium: TextStyle(fontSize: 28),
        headlineSmall: TextStyle(fontSize: 24),
        titleLarge: TextStyle(fontSize: 22),
        titleMedium: TextStyle(fontSize: 16),
        titleSmall: TextStyle(fontSize: 14),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      ),
      dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      )
      // textSelectionTheme: theme.textSelectionTheme.copyWith(
      //   cursorColor: primaryColor,
      //   selectionColor: primaryColor,
      // ),
      );

  return theme.copyWith(
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // foregroundColor: theme.colorScheme.onSurface,
      backgroundColor: Color.fromARGB(
          255, 255, 100, 100), //theme.colorScheme.primaryContainer //
    ),
  );
}

/// Theme extension styles
///
/// To use it you only need to type `context.dispL` to get displayLarge style
/// and so on with the rest of styles, instead of:
/// `Theme.of(context).textTheme.displayLarge`
extension UIThemeExtension on BuildContext {
  TextStyle? get dispL => Theme.of(this).textTheme.displayLarge;
  TextStyle? get dispM => Theme.of(this).textTheme.displayMedium;
  TextStyle? get dispS => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headL => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headM => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headS => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleL => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleM => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleS => Theme.of(this).textTheme.titleSmall;

  TextStyle? get bodyL => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyM => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodyS => Theme.of(this).textTheme.bodySmall;

  TextStyle? get labelL => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelM => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelS => Theme.of(this).textTheme.labelSmall;
}
