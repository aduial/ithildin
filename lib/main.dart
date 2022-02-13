import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ithildin/screen/ithildin_screen.dart';
import 'package:json_theme/json_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(IthildinApp(theme: theme));
}

class IthildinApp extends StatelessWidget {
  final ThemeData theme;
  const IthildinApp({Key? key, required this.theme}) : super(key: key);

  static const String title = 'Ithildin languages';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: title,
      // themeMode: ThemeMode.dark,
      theme: theme,
      home: const IthildinScreen(),
      );
    }
  }