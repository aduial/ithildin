import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ithildin/screen/ithildin_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const IthildinApp());
}

class IthildinApp extends StatelessWidget {
  static const String title = 'Ithildin languages';
  const IthildinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(


      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColorDark: Colors.blueGrey.shade900,
        primaryColor: Colors.blueGrey.shade700,
        primaryColorLight: Colors.blueGrey.shade400,
        buttonColor: Colors.blue.shade800,
        dividerColor: Colors.deepOrangeAccent,
        accentColor: Colors.lime.shade500,




        scaffoldBackgroundColor: Colors.lightBlue.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 1,
        ),
      ),
      home: const IthildinScreen(),
      // home: LanguagesScreen(),

    );


  }

}