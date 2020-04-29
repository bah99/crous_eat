import 'dart:io';
// import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crous_eat/app_theme.dart';

import 'food_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        title: 'Crous Eat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Comfortaa',
            brightness: Brightness.light,
            primaryColor: Colors.white,
            // primarySwatch: Colors.indigo,
            textTheme: AppTheme.textTheme,
            platform: TargetPlatform.android),
        home: CrousHomeScreen());
  }
  

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
