import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

  static const _defaultElevation = 2.5;
  static const _defaultFontFamily = null;

  static ThemeData _baseTheme(
    Brightness brightness, {
    Color? textColor,
    Color? accentColor,
    Color? onAccentColor,
    Color? scaffoldBackgroundColor,
  }) {
    late final ColorScheme defaultColorScheme;

    /// The other brightness...
    ///
    /// if [brightness] is [Brightness.light],
    /// then [contrastingBrightness] is [Brightness.dark].
    ///
    /// if [brightness] is [Brightness.dark],
    /// then [contrastingBrightness] is [Brightness.light].
    late final Brightness contrastingBrightness;

    switch (brightness) {
      case Brightness.light:
        defaultColorScheme = const ColorScheme.light();
        contrastingBrightness = Brightness.dark;
        textColor ??= Colors.black;
        break;
      case Brightness.dark:
        defaultColorScheme = const ColorScheme.dark();
        contrastingBrightness = Brightness.light;
        textColor ??= Colors.white;
        break;
    }

    final systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarBrightness: brightness,
      statusBarColor: scaffoldBackgroundColor,
      systemNavigationBarColor: scaffoldBackgroundColor,
      systemNavigationBarDividerColor: scaffoldBackgroundColor,
      statusBarIconBrightness: contrastingBrightness,
      systemNavigationBarIconBrightness: contrastingBrightness,
    );

    final _iconThemeData = IconThemeData(color: accentColor);

    return ThemeData(
      brightness: brightness,
      fontFamily: _defaultFontFamily,
      iconTheme: _iconThemeData,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        elevation: _defaultElevation,
        systemOverlayStyle: systemUiOverlayStyle,
        color: scaffoldBackgroundColor,
        iconTheme: _iconThemeData,
        actionsIconTheme: _iconThemeData,
        titleTextStyle: TextStyle(
          color: textColor,
          fontFamily: _defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      colorScheme: defaultColorScheme.copyWith(
        brightness: brightness,
        // primary: accentColor,
        secondary: accentColor,
        onSecondary: onAccentColor ?? textColor,
      ),
      toggleableActiveColor: accentColor,
      // textSelectionTheme: TextSelectionThemeData(
      //   cursorColor: accentColor,
      //   selectionColor: accentColor?.withOpacity(0.75),
      //   selectionHandleColor: accentColor?.withOpacity(0.75),
      // ),
      dialogTheme: DialogTheme(
        elevation: _defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: _defaultElevation,
        highlightElevation: _defaultElevation * 2,
        // backgroundColor: accentColor,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: _defaultElevation,
        backgroundColor: accentColor,
        contentTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: _defaultFontFamily,
          color: onAccentColor ?? textColor,
        ),
        behavior: SnackBarBehavior.floating,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      // cupertinoOverrideTheme: CupertinoThemeData(
      //   brightness: brightness,
      //   scaffoldBackgroundColor: scaffoldBackgroundColor,
      // ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          for (final targetValue in TargetPlatform.values)
            targetValue: const _SlideLeftTransitionsBuilder(),
        },
      ),
    );
  }

  static final lightTheme = _baseTheme(
    Brightness.light,
    accentColor: const Color(0xFF0669F8),
    onAccentColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFFDCDFE2),
  ).copyWith(
    cardColor: const Color(0xFFCACFD6),
  );

  static final darkTheme = _baseTheme(
    Brightness.dark,
    accentColor: Colors.tealAccent,
    onAccentColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xFF040F2D),
  ).copyWith(
    cardColor: const Color(0xFF091642),
  );
}

class _SlideLeftTransitionsBuilder extends PageTransitionsBuilder {
  const _SlideLeftTransitionsBuilder();

  @override
  Widget buildTransitions<T>(_, __, animation, ___, child) {
    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ).drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: child,
    );
  }
}
