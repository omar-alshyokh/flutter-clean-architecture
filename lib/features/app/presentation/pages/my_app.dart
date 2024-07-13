import 'package:flutter/material.dart';
import 'package:starter/core/constants/app_colors.dart';
import 'package:starter/core/constants/app_strings.dart';
import 'package:starter/core/di/di.dart';
import 'package:starter/core/managers/navigation/app_navigator.dart';
import 'package:starter/features/auth/presentation/pages/login_page.dart';
import 'package:starter/features/home/presentation/pages/home_page.dart';
import 'package:starter/features/splash/presentation/pages/splash_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: findDep<AppNavigator>().navigatorKey,
      title: AppStrings.appName,
      initialRoute: SplashPage.routeName,
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          primaryColor: AppColors.primaryColor,
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: AppColors.blueWhite, //change your color here
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      // navigatorObservers: [BluetoothAdapterStateObserver()],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case SplashPage.routeName:
            {
              return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (_, __, ___) => const SplashPage());
            }
          case HomePage.routeName:
            {
              return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (_, __, ___) => const HomePage());
            }
          case LoginPage.routeName:
            {
              return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (_, __, ___) => const LoginPage());
            }
        }
        return null;
      },
    );
  }
}