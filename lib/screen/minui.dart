import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/colours.dart';
import 'ithildin_screen.dart';

class Minui extends StatefulWidget {
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
    return Scaffold(
      backgroundColor: BlueTop,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          width: 130.0,
                          height: 50.0,
                        ),
                        Transform.rotate(
                          angle: 180,
                          child: const Icon(
                            Icons.star,
                            color: Ithildin,
                            size: 50,
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Text(
              "Ithildin",
              style: GoogleFonts.notoSerifDisplay(
                textStyle: Theme.of(context).textTheme.bodyText1,
                fontWeight: FontWeight.w200,
                fontSize: 70,
              ),
            ),
            Text(
              "an Elvish dictionary",
              style: GoogleFonts.notoSerifDisplay(
                textStyle: Theme.of(context).textTheme.bodyText1,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 30.0,
            ),
            const SizedBox(
              width: double.infinity,
              height: 50.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: YellowGrey,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: SortOfRed,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 35.0,
              child: DecoratedBox(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 10),
                  child: Text(
                    "A dictionary of Tolkienian languages based on the Eldamo Lexicon by Paul Strack.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
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
                          fontSize: 16,
                          color: Ithildin,
                        ),
                      ),
                      color: SortOfRed,
                    ),
                  ]),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                color: MountainBlue,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 10),
                  child: Text(
                    "Usage: tap the [i] icon top right in the next screen",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
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
