import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/config/user_preferences.dart';
import 'package:ithildin/screen/ithildin_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../config/colours.dart';
import '../config/config.dart';

class SearchMatch extends StatefulWidget {
  const SearchMatch({Key? key}) : super(key: key);

  @override
  _SearchMatchState createState() => _SearchMatchState();
}

class _SearchMatchState extends State<SearchMatch> {

  // width iPhone 11 Pro max = 414
  final double refWidth = 448;

  @override
  Widget build(BuildContext context) {
    double toScale = MediaQuery.of(context).size.width / refWidth ;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: RegularResultBGColour,
        title: Text("search matching"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.arrowtriangle_down_square,
                color: BrightGreen),
            onPressed: () => Navigator.pop(context, false),
            tooltip: 'cancel',
          )
        ],
      ),
      backgroundColor: BlueGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Text(
                "how should search terms match?",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Ithildin, fontSize: 18 * toScale)
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                    const EdgeInsetsDirectional.fromSTEB(10, 1, 10, 1),

                    child: ToggleSwitch(
                      activeBorders: [
                        Border.all(
                          color: LightAnyMatchColour,
                          width: 2.0 * toScale,
                        ),
                        Border.all(
                          color: LightStartMatchColour,
                          width: 2.0 * toScale,
                        ),
                        Border.all(
                          color: LightEndMatchColour,
                          width: 2.0 * toScale,
                        ),
                        Border.all(
                          color: LightVerbatimMatchColour,
                          width: 2.0 * toScale,
                        ),
                        Border.all(
                          color: LightRegexMatchColour,
                          width: 2.0 * toScale,
                        ),
                      ],
                      activeFgColor: Laurelin,
                      inactiveFgColor: LightBlueGrey,
                      isVertical: true,
                      minWidth: 250.0 * toScale,
                      radiusStyle: true,
                      cornerRadius: 20.0 * toScale,
                      customIcons: [
                        Icon(
                          CupertinoIcons.search,
                          color: Laurelin,
                          size: 20.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.arrow_left_to_line,
                          color: Laurelin,
                          size: 20.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.arrow_right_to_line,
                          color: Laurelin,
                          size: 20.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.equal,
                          color: Laurelin,
                          size: 20.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.ellipsis,
                          color: Laurelin,
                          size: 20.0 * toScale,
                        )
                      ],
                      initialLabelIndex: UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex,
                      activeBgColors: const [
                        [DarkAnyMatchColour],
                        [DarkStartMatchColour],
                        [DarkEndMatchColour],
                        [DarkVerbatimMatchColour],
                        [DarkRegexMatchColour]
                      ],
                      labels: matchingMethods,
                      fontSize: 20 * toScale,
                      iconSize: 20.0 * toScale,
                      onToggle: (index) {
                        setState(() {
                          UserPreferences.setMatchMethod(index!);
                        });
                        Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            Navigator.pop(context, true);
                          });
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding:
                    const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 10),
                    child: Text(
                      "(all examples with language set to Sindarin)\n\n"
                          "Anywhere: 'ui' matches 'uial', 'aduial', 'ui' and 'tollui'\n\n"
                          "Start: 'ui' matches 'uial' and 'ui'\n\n"
                          "End: 'ui' matches 'ui' and 'tollui'\n\n"
                          "Verbatim: 'ui' matches 'ui' only\n\n"
                          "Regex: for more complex searches, you can use regular "
                          "expressions, for instance: '^ae.+[a|i].\$', which matches words "
                          "starting with 'ae' and having an 'a' or an 'i' as penultimate "
                          "letter: 'Aeglir', 'Aelin','Aelin-uial', Aeluin' and "
                          "'Aerlinn in Edhil o Imladris'\n\n"
                          "The search-field is cleared when switching from regex "
                          "searching to another type.",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          color: Ithildin,
                          fontWeight: FontWeight.w300,
                          fontSize: 15 * toScale),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
