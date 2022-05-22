import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ithildin/screen/ithildin_screen.dart';
import 'package:ithildin/screen/minui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/colours.dart';
import 'config/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserPreferences.init();
  runApp(const IthildinApp());
}

class IthildinApp extends StatelessWidget {
  const IthildinApp({Key? key}) : super(key: key);
  static const String title = 'Ithildin Dictionary';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: UserPreferences.getShowMinuiNotNull()
        ? Minui()
        : IthildinScreen(),
        themeMode: ThemeMode.system,
        theme: ThemeData.light().copyWith(
            primaryColor: RegularResultBGColour,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: TanteRia, // background color
                    textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                )
            ),
            textTheme: TextTheme(
              headline1: GoogleFonts.notoSerifDisplay(
                fontSize: 101,
                fontWeight: FontWeight.w200,
                letterSpacing: -1.5,
                color: ithildin,
              ),
              headline2: GoogleFonts.notoSerifDisplay(
                fontSize: 63,
                fontWeight: FontWeight.w200,
                letterSpacing: -0.5,
                color: ithildin,
              ),
              headline3: GoogleFonts.notoSerifDisplay(
                fontSize: 50,
                fontWeight: FontWeight.w200,
                color: ithildin,
              ),
              headline4: GoogleFonts.lato(
                fontSize: 36,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: ThemeTextColour,
              ),
              headline5: GoogleFonts.lato(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: ThemeTextColour,
              ),
              headline6: GoogleFonts.lato(
                fontSize: 21,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: ThemeTextColour,
              ),
              subtitle1: GoogleFonts.lato(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
                color: ThemeTextColour,
              ),
              subtitle2: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
                color: ThemeTextColour,
              ),
              bodyText1: GoogleFonts.lato(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: ThemeTextColour,
              ),
              bodyText2: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: ThemeTextColour,
              ),
              button: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25,
                color: ThemeTextColour,
              ),
              caption: GoogleFonts.lato(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
                color: ThemeTextColour,
              ),
              overline: GoogleFonts.lato(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                color: ThemeTextColour,
              ),
            )));
  }
}
