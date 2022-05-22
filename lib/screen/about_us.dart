import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colours.dart';
import '../config/config.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double toScale = (MediaQuery.of(context).size.width / refWidth) *
        (MediaQuery.of(context).size.height / refHeight);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MountainBlue,
        title: const Text('about this app'),
      ),
      backgroundColor: blueTop,
      body: SafeArea(
        bottom: false,
        //child: Padding(
          //padding: EdgeInsetsDirectional.fromSTEB(0, 10 * toScale, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10 * toScale, 10 * toScale, 10 * toScale, 10 * toScale),
                  child: Text(
                    "Ithildin",
                    style: GoogleFonts.notoSerifDisplay(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontWeight: FontWeight.w200,
                      fontSize: 60 * toScale,
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10 * toScale, 10 * toScale, 10 * toScale, 10 * toScale),
                //   child: Text(
                //     "Ithildin is a dictionary of the languages described in the "
                //     "work of JRR Tolkien. Based on the Eldamo.org lexicon, it "
                //     "contains a near-complete searchable vocabulary of those languages.",
                //     textAlign: TextAlign.center,
                //     style: Theme.of(context).textTheme.bodyText2!.copyWith(
                //         color: Ithildin,
                //         fontWeight: FontWeight.w300,
                //         fontStyle: FontStyle.italic,
                //         fontSize: 12 * toScale),
                //   ),
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 15.0 * toScale,
                // ),
                SizedBox(
                  width: double.infinity,
                  height: 25.0 * toScale,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: yellowGrey,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 10.0 * toScale,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: SortOfRed,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 18.0 * toScale,
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
                      padding:
                        EdgeInsetsDirectional.fromSTEB(20 * toScale, 20 * toScale, 20 * toScale, 10 * toScale),
                      child: Text(
                        "Ithildin is a dictionary of the languages conceived by J.R.R. Tolkien. The vocabulary was "
                            "compiled by the efforts of many, most notably Christopher Tolkien and the authors of "
                            "Parma Eldalamberon and Vinyar Tengwar (Christopher Gilson, Carl Hostetter, Arden Smith, "
                            "Bill Welden, Patrick Wynne, and others) and consistenly organised in the Eldamo lexicon "
                            "by Paul Strack.\n\n"
                        "Thanks to those efforts, this dictionary contains a near-complete searchable vocabulary of "
                            "those languages. It is intended as a practical tool for those interested in understanding "
                            "or creating Elvish prose or poetry. For anything beyond that: grammar, phonology, history, "
                            "linguistic development and many other resources, we kindly refer to https://eldamo.org.\n\n"
                        "None of the material presented herein belongs to us. We are not affiliated with the Tolkien "
                            "Estate nor with Middle-earth Enterprises. No profit is being made from this app: it is a "
                            "service of, and for enthusiasts of JRR Tolkien's work and is distributed for free, licensed "
                            "under Creative Commons ShareAlike 4.0 (https://creativecommons.org/licenses/by-sa/4.0/).",
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
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    color: MountainBlue,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10 * toScale, 10 * toScale, 20 * toScale, 0),
                      child: Text(
                        "Original lexicon data compiled by\nPaul Strack, https://eldamo.org\n\n"
                        "Application concept & specification by\nEryn Galen, Roman Rausch, Lúthien Dulk\n\n"
                        "Data parsing and application coding: https://animatrice.nl",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: ithildin,
                            fontWeight: FontWeight.w300,
                            fontSize: 14 * toScale),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        //),
      ),
    );
  }
}
