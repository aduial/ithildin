import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/config/user_preferences.dart';
import 'package:ithildin/screen/regex.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../config/colours.dart';
import '../config/config.dart';

class SearchMatch extends StatefulWidget {
  const SearchMatch({Key? key}) : super(key: key);

  @override
  _SearchMatchState createState() => _SearchMatchState();
}

Route _regexRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Regex(),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _SearchMatchState extends State<SearchMatch> {
  @override
  Widget build(BuildContext context) {
    double toScale = (MediaQuery.of(context).size.width / refWidth) *
        (MediaQuery.of(context).size.height / refHeight);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: RegularResultBGColour,
        title: const Text("search matching"),
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
          padding: EdgeInsetsDirectional.fromSTEB(10 * toScale, 6 * toScale, 10 * toScale, 4 * toScale),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10 * toScale, 14 * toScale, 10 * toScale, 0),
                child: Text("how should search terms match?",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: ithildin, fontSize: 18 * toScale)),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10 * toScale, toScale, 10 * toScale, toScale),
                    child: ToggleSwitch(
                      activeBorders: [
                        Border.all(
                          color: LightAnyMatchColour,
                          width: 2.0 * toScale,
                        ),
                        Border.all(
                          color: LightStrictAnyMatchColour,
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
                      cornerRadius: 18.0 * toScale,
                      customIcons: [
                        Icon(
                          CupertinoIcons.search,
                          color: Laurelin,
                          size: 16.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.search_circle,
                          color: Laurelin,
                          size: 16.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.arrow_left_to_line,
                          color: Laurelin,
                          size: 16.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.arrow_right_to_line,
                          color: Laurelin,
                          size: 16.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.equal,
                          color: Laurelin,
                          size: 16.0 * toScale,
                        ),
                        Icon(
                          CupertinoIcons.ellipsis,
                          color: Laurelin,
                          size: 16.0 * toScale,
                        )
                      ],
                      initialLabelIndex: UserPreferences.getMatchMethod() ??
                          defaultMatchingMethodIndex,
                      activeBgColors: const [
                        [DarkAnyMatchColour],
                        [DarkStrictAnyMatchColour],
                        [DarkStartMatchColour],
                        [DarkEndMatchColour],
                        [DarkVerbatimMatchColour],
                        [DarkRegexMatchColour]
                      ],
                      labels: matchingMethods,
                      fontSize: 16 * toScale,
                      iconSize: 16.0 * toScale,
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
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10 * toScale, 2 * toScale, 10 * toScale, 2 * toScale),
                    child: Text(
                      "Anywhere: 'ui' matches 'uial', 'aduial', 'ui' and 'tollui'.\n"
                      "Loose matching: eg., finds þ, ñ on s, n.\n\n"
                      "Strict: matches ALL characters exactly\n\n"
                      "Start: 'ui' matches 'uial' and 'ui'\n\n"
                      "End: 'ui' matches 'ui' and 'tollui'\n\n"
                      "Verbatim: 'ui' matches 'ui' only\n\n"
                      "Regex: for more complex searches, you can use regular "
                      "expressions (click on the button below for a short introduction).",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ithildin,
                          fontWeight: FontWeight.w300,
                          fontSize: 15 * toScale),
                    ),
                  ),
                ),
              ),
              Container(
                //height: 50.0 * toScale,
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(_regexRoute());
                          });
                        },
                        color: RegularResultBGColour,
                        child: Text(
                          "Regex primer",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Telperion,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14 * toScale),
                        ),
                      ),
                    ]),
              ),Expanded(
                //flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10 * toScale, 2 * toScale, 10 * toScale, 6 * toScale),
                    child: Text(
                      "The search-field is cleared when switching from regex "
                          "searching to another type.",
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
      ),
    );
  }
}
