import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/config/user_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../config/colours.dart';
import '../config/config.dart';

class Regex extends StatefulWidget {
  const Regex({Key? key}) : super(key: key);

  @override
  _RegexState createState() => _RegexState();
}

class _RegexState extends State<Regex> {
  @override
  Widget build(BuildContext context) {
    double toScale = (MediaQuery.of(context).size.width / refWidth) *
        (MediaQuery.of(context).size.height / refHeight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: RegularResultBGColour,
        title: Text("Regular Expressions"),
      ),
      backgroundColor: BlueGrey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              10 * toScale, 6 * toScale, 10 * toScale, 6 * toScale),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    10 * toScale, 20 * toScale, 10 * toScale, 20 * toScale),
                child: Text("A short introduction:",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: ithildin, fontSize: 18 * toScale)),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        10 * toScale, 6 * toScale, 10 * toScale, 6 * toScale),
                    child: Text(
                      "you can think of Regular Expressions (or 'Regex') as building on the idea of "
                      "wildcards or 'jokers' like ? (matching one letter) and * (any number of letters), "
                      "but allowing for much more than just that. \n\nWe can only cover the very basics here, check "
                      "out www.regular-expressions.info if you want to know more.\n\n"
                      "Most letters just match themselves letters, but:\n"
                      ". (a period) = any one character (incl. whitespace)\n "
                      "\\w = a letter\n "
                      "\\s = a whitespace or tab\n"
                      "\\d = a digit\n\n"
                      "Repeating a pattern:\n"
                      "* = zero or more times\n"
                      "+ = one or more times\n\n"
                      "Use square brackets to search for a set or range:\n"
                      "[a-z] = single letter in the range a to z\n"
                      "[fmnq] = single letter from the set {f,m,n,q}\n"
                      "[^aeiou] = single vowel (NOT in {a,e,i,o,u}): \n"
                      "[a-eA-E] = lower- and uppercase a, b, c, d or e\n\n"
                      "Enter choices (alternations) separated by | :\n"
                      "adan|edhel = adan or edhel \n\n"
                      "^ = start of word/line \n "
                      "\$ = end of word/line \n\n"
                      "Use \\.   \\*   \\+   \\^   \\\$   to match a literal  .   *   +   ^   \$",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ithildin,
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
