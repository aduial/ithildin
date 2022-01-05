import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ithildin/screen/ithildin_screen.dart';
import 'package:ithildin/screen/languages_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final String title = 'Ithildin languages';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.blueGrey.shade700,
      scaffoldBackgroundColor: Colors.blue.shade100,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
        elevation: 1,
      ),
    ),
    home: IthildinScreen(),
    // home: LanguagesScreen(),
  );
}