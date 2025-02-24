import 'package:drinks/controllers/theme_controller.dart';
import 'package:drinks/screens/splash_screen.dart';
import 'package:drinks/services/local_storage.dart';
import 'package:drinks/utils/app_theme.dart';
import 'package:drinks/utils/globals.dart';
import 'package:drinks/utils/route_generator.dart';
import 'package:drinks/widgets/flutter_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // set custom error page
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return FlutterErrorWidget(errorDetails: errorDetails);
  };

  // initialize
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    LocalStorage.initialize(),
  ]);

  // end
  FlutterNativeSplash.remove();
  runApp(const _MainApp());
}

class _MainApp extends StatelessWidget {
  const _MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: _appBuilder,
        scrollBehavior:  _DefaultScrollBehavior(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeController.of(context).themeMode,
        navigatorKey: Globals.navigatorKey,
        scaffoldMessengerKey: Globals.scaffoldMessengerKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashScreen.id,
      ),
    );
  }

  Widget _appBuilder(BuildContext context, Widget? child) {
    final appBarOverlayStyle = Theme.of(context).appBarTheme.systemOverlayStyle;
    if (appBarOverlayStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(appBarOverlayStyle);
    }

    return child!;
  }
}

class _DefaultScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

