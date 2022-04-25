import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colours.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MountainBlue,
        title: const Text('about this app'),
      ),
      backgroundColor: BlueTop,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    "Ithildin",
                    style: GoogleFonts.notoSerifDisplay(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontWeight: FontWeight.w200,
                      fontSize: 45,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    "Ithildin is a dictionary of the languages described in the "
                    "work of JRR Tolkien. Based on the Eldamo.org lexicon, it "
                    "contains a near-complete searchable vocabulary of those languages.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Ithildin,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 12),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 15.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 25.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: YellowGrey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 10.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: SortOfRed,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 18.0,
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 10),
                      child: Text(
                        "The original vocabulary presented in this application was conceived "
                        "by J.R.R. Tolkien and compiled by the efforts of many, most "
                        "notably Christopher Tolkien and the authors of Parma Eldalamberon "
                        "and Vinyar Tengwar (Christopher Gilson, Carl Hostetter, Arden Smith, "
                        "Bill Welden, Patrick Wynne, and others).\n\n"
                        "Paul Strack's Eldamo lexicon attempts to consistenly organise all that material. "
                        "This dictionary is intended as a practical tool for whoever want to read or write Elvish "
                        "prose or poetry.\nFor anything beyond that, eg. grammar, phonology, history, "
                        "linguistic development and many other resources, we kindly refer to https://eldamo.org.\n\n"
                        "None of the material presented herein belongs to us; we are not affiliated with the "
                        "Tolkien Estate nor with Middle-earth Enterprises. This application is solely a "
                        "service of, and for enthusiasts of JRR Tolkien's work.\n\n No profit is being made from "
                        "this app. It is distributed for free, licensed under Creative Commons ShareAlike "
                        "4.0: https://creativecommons.org/licenses/by-sa/4.0/",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Ithildin,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    color: MountainBlue,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 10),
                      child: Text(
                        "Original lexicon data compiled by\nPaul Strack, https://eldamo.org\n\n"
                        "Application concept & specification by\nEryn Galen, Roman Rausch, Lúthien Dulk\n\n"
                        "Data parsing and application coding: https://animatrice.nl",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Ithildin,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
