import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/colours.dart';
import '../config/config.dart';
import '../config/user_preferences.dart';
import 'ithildin_screen.dart';

class Minui extends StatefulWidget {
  const Minui({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MinuiState();
}

class _MinuiState extends State<Minui> {

  getOnWithIt() {
    Future.delayed(Duration.zero, () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const IthildinScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double toScale = MediaQuery.of(context).size.width / refWidth ;

    return Scaffold(
      backgroundColor: blueTop,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30 * toScale, 40 * toScale, 30 * toScale, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         SizedBox(
                          width: 130.0 * toScale,
                          height: 50.0 * toScale,
                        ),
                        Transform.rotate(
                          angle: 180,
                          child: Icon(
                            Icons.star,
                            color: ithildin,
                            size: 50 * toScale,
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Text(
              "Ithildin",
              style: GoogleFonts.notoSerifDisplay(
                textStyle: Theme.of(context).textTheme.headline1,
                fontWeight: FontWeight.w200,
                fontSize: 70 * toScale,
              ),
            ),
            Text(
              "an Elvish dictionary",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: ithildin,
                  fontWeight: FontWeight.w300,
                  // fontStyle: FontStyle.italic,
                  fontSize: 24 * toScale),
            ),
             SizedBox(
              width: double.infinity,
              height: 30.0 * toScale,
            ),
             SizedBox(
              width: double.infinity,
              height: 50.0 * toScale,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: yellowGrey,
                ),
              ),
            ),
             SizedBox(
              width: double.infinity,
              height: 20.0 * toScale,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: SortOfRed,
                ),
              ),
            ),
             SizedBox(
              width: double.infinity,
              height: 35.0 * toScale,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: IceBlue,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: MountainBlue,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30 * toScale, 30 * toScale, 30 * toScale, 10 * toScale),
                  child: Text(
                    "A dictionary of Tolkienian languages based on the Eldamo Lexicon by Paul Strack.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: ithildin,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 15 * toScale),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0 * toScale,
              color: MountainBlue,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () => {
                        getOnWithIt(),
                      },
                      child: Text(
                        "OK",
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          fontWeight: FontWeight.w600,
                          fontSize: 16 * toScale,
                          color: ithildin,
                        ),
                      ),
                      color: SortOfRed,
                    ),
                  ]),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                color: MountainBlue,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30 * toScale, 20 * toScale, 30 * toScale, 0),
                  child: Text(
                    "Usage: tap the (?) icon top right in the next screen",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: ithildin,
                        fontWeight: FontWeight.w300,
                        fontSize: 12 * toScale),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: MountainBlue,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30 * toScale, 0, 30 * toScale, 0),
                  child: CheckboxListTile(
                    enableFeedback: true,
                      activeColor: ithildin,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(20 * toScale, 0, 60 * toScale, 0),
                      visualDensity: VisualDensity.compact,
                      checkColor: blueTop,
                      side: const BorderSide(
                        color: ithildin,
                        width: 1.0,
                        style: BorderStyle.solid
                      ),
                      title: Text(
                        "Show this screen next time",
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: ithildin,
                            fontWeight: FontWeight.w300,
                            fontSize: 14 * toScale),
                      ),
                      value: UserPreferences.getShowMinuiNotNull(),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          UserPreferences.setShowMinui(isChecked!);
                        });
                      }

                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
