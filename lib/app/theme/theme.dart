// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import '../config/constant_config.dart';
import 'app_font_size.dart';
import 'app_padding.dart';

@immutable
class CustomTheme extends ThemeExtension<CustomTheme> {
  const CustomTheme(
      {required this.isLight,
      this.primaryColor = AppColor.primaryColor,
      this.tertiaryColor = AppColor.tertiaryColor,
      this.secondaryColor = AppColor.secondaryColor,
      this.neutralColor = AppColor.neutralColor,
      this.greenColor = AppColor.greenColor,
      this.redColor = AppColor.lightRedColor,
      this.whiteColor = AppColor.whiteColor,
      this.blackColor = AppColor.blackColor});

  final Color primaryColor;
  final Color tertiaryColor;
  final Color secondaryColor;
  final Color neutralColor;
  final Color whiteColor;
  final Color blackColor;
  final Color greenColor;
  final Color redColor;
  final bool isLight;

  Scheme _schemeLight() {
    final base = CorePalette.of(primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(tertiaryColor.value).primary;
    final neutral = CorePalette.of(neutralColor.value).neutral;
    return Scheme(
      primary: primary.get(40),
      onPrimary: primary.get(100),
      primaryContainer: primary.get(90),
      onPrimaryContainer: primary.get(10),
      secondary: base.secondary.get(40),
      onSecondary: base.secondary.get(100),
      secondaryContainer: base.secondary.get(90),
      onSecondaryContainer: base.secondary.get(10),
      tertiary: tertiary.get(40),
      onTertiary: tertiary.get(100),
      tertiaryContainer: tertiary.get(90),
      onTertiaryContainer: tertiary.get(10),
      error: base.error.get(40),
      onError: base.error.get(100),
      errorContainer: base.error.get(90),
      onErrorContainer: base.error.get(10),
      background: neutral.get(98),
      onBackground: neutral.get(6),
      surface: neutral.get(99),
      onSurface: neutral.get(10),
      outline: base.neutralVariant.get(50),
      outlineVariant: base.neutralVariant.get(80),
      surfaceVariant: base.neutralVariant.get(90),
      onSurfaceVariant: base.neutralVariant.get(30),
      shadow: neutral.get(0),
      scrim: neutral.get(0),
      inverseSurface: neutral.get(20),
      inverseOnSurface: neutral.get(95),
      inversePrimary: primary.get(40),
    );
  }

  Scheme _schemeDark() {
    final base = CorePalette.of(primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(tertiaryColor.value).primary;
    final neutral = CorePalette.of(neutralColor.value).neutral;
    return Scheme(
      primary: primary.get(80),
      onPrimary: primary.get(20),
      primaryContainer: primary.get(30),
      onPrimaryContainer: primary.get(90),
      secondary: base.secondary.get(80),
      onSecondary: base.secondary.get(20),
      secondaryContainer: base.secondary.get(30),
      onSecondaryContainer: base.secondary.get(90),
      tertiary: tertiary.get(80),
      onTertiary: tertiary.get(20),
      tertiaryContainer: tertiary.get(30),
      onTertiaryContainer: tertiary.get(90),
      surface: neutral.get(6),
      onSurface: neutral.get(90),
      background: neutral.get(6),
      onBackground: neutral.get(90),
      error: base.error.get(80),
      onError: base.error.get(20),
      errorContainer: base.error.get(30),
      onErrorContainer: base.error.get(90),
      outline: base.neutralVariant.get(60),
      outlineVariant: base.neutralVariant.get(30),
      surfaceVariant: base.neutralVariant.get(30),
      onSurfaceVariant: base.neutralVariant.get(80),
      shadow: neutral.get(0),
      scrim: neutral.get(0),
      inverseSurface: neutral.get(90),
      inverseOnSurface: neutral.get(20),
      inversePrimary: primary.get(40),
    );
  }

  ThemeData _base(final ColorScheme colorScheme) {
    const primaryTextTheme = TextTheme(
      displayLarge: TextStyle(
          fontSize: AppFontSize.displayLarge, fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          fontSize: AppFontSize.displayMedium, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(
          fontSize: AppFontSize.displaySmall, fontWeight: FontWeight.w300),

      headlineLarge: TextStyle(
          fontSize: AppFontSize.headLineLarge, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontSize: AppFontSize.headLineMedium, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          fontSize: AppFontSize.headLineSmall, fontWeight: FontWeight.w700),

      titleLarge: TextStyle(
          fontSize: AppFontSize.titleLarge, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
          fontSize: AppFontSize.titleMedium, fontWeight: FontWeight.w400),
      titleSmall: TextStyle(
          fontSize: AppFontSize.titleSmall, fontWeight: FontWeight.w300),

      bodyLarge: TextStyle(
          fontSize: AppFontSize.bodyLarge, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          fontSize: AppFontSize.bodyMedium, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontSize: AppFontSize.bodySmall, fontWeight: FontWeight.w400),

      labelLarge: TextStyle(
          fontSize: AppFontSize.labelMedium, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          fontSize: AppFontSize.labelMedium, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(
          fontSize: AppFontSize.labelSmall, fontWeight: FontWeight.w300),
      // Other text styles...
    );
    const secondaryTextTheme = TextTheme();
    final textTheme = primaryTextTheme.copyWith(
      displaySmall: secondaryTextTheme.displaySmall,
      displayMedium: secondaryTextTheme.displayMedium,
      displayLarge: secondaryTextTheme.displayLarge,
      headlineSmall: secondaryTextTheme.headlineSmall,
      headlineMedium: secondaryTextTheme.headlineMedium,
      headlineLarge: secondaryTextTheme.headlineLarge,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: ConstantConfig.mulish,
      extensions: [this],
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        toolbarHeight: AppPadding.appBar,
        color: AppColor.pageBackground,
        surfaceTintColor: AppColor.pageBackground,
      ),
      cardTheme: CardTheme(color: colorScheme.surfaceContainerHighest),
      scaffoldBackgroundColor: isLight ? neutralColor : colorScheme.surface,
      tabBarTheme: TabBarTheme(
          labelColor: colorScheme.onSurface,
          unselectedLabelColor: colorScheme.onSurface,
          indicator: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: colorScheme.primary, width: 2)))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer),
      navigationRailTheme: NavigationRailThemeData(
          backgroundColor: isLight ? neutralColor : colorScheme.surface,
          selectedIconTheme:
              IconThemeData(color: colorScheme.onSecondaryContainer),
          indicatorColor: colorScheme.secondaryContainer),
      chipTheme: ChipThemeData(
          backgroundColor: isLight ? neutralColor : colorScheme.surface),
    );
  }

  ThemeData toThemeData() {
    final colorScheme = _schemeLight().toColorScheme(Brightness.light);
    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }

  ThemeData toThemeDataDark() {
    final colorScheme = _schemeDark().toColorScheme(Brightness.dark);
    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }

  @override
  ThemeExtension<CustomTheme> copyWith({
    Color? primaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) =>
      CustomTheme(
        isLight: isLight,
        primaryColor: primaryColor ?? this.primaryColor,
        tertiaryColor: tertiaryColor ?? this.tertiaryColor,
        neutralColor: neutralColor ?? this.neutralColor,
      );

  @override
  CustomTheme lerp(
    covariant ThemeExtension<CustomTheme>? other,
    double t,
  ) {
    if (other is! CustomTheme) return this;
    return CustomTheme(
      isLight: isLight,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }
}

extension on Scheme {
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      primaryContainer: Color(primaryContainer),
      onPrimaryContainer: Color(onPrimaryContainer),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      secondaryContainer: Color(secondaryContainer),
      onSecondaryContainer: Color(onSecondaryContainer),
      tertiary: Color(tertiary),
      onTertiary: Color(onTertiary),
      tertiaryContainer: Color(tertiaryContainer),
      onTertiaryContainer: Color(onTertiaryContainer),
      error: Color(error),
      onError: Color(onError),
      errorContainer: Color(errorContainer),
      onErrorContainer: Color(onErrorContainer),
      outline: Color(outline),
      outlineVariant: Color(outlineVariant),
      surface: Color(surface),
      onSurface: Color(onSurface),
      surfaceContainerHighest: Color(surfaceVariant),
      onSurfaceVariant: Color(onSurfaceVariant),
      inverseSurface: Color(inverseSurface),
      onInverseSurface: Color(inverseOnSurface),
      inversePrimary: Color(inversePrimary),
      shadow: Color(shadow),
      scrim: Color(scrim),
      surfaceTint: Color(primary),
      brightness: brightness,
    );
  }
}
