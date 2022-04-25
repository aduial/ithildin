import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/config/user_preferences.dart';
import '../config/colours.dart';
import '../config/config.dart';

class LanguageSets extends StatefulWidget {
  const LanguageSets({Key? key}) : super(key: key);

  @override
  _LanguageSetsState createState() => _LanguageSetsState();
}

class _LanguageSetsState extends State<LanguageSets> {

  final double refWidth = 448;

  @override
  Widget build(BuildContext context) {
    double toScale = MediaQuery.of(context).size.width / refWidth ;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: RegularResultBGColour,
        title: Text("choose language set"),
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
          padding: EdgeInsetsDirectional.fromSTEB(10 * toScale, 10 * toScale, 10 * toScale, 10 * toScale),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10 * toScale, 20 * toScale, 10 * toScale, 20 * toScale),
                    child: ListView.builder(
                      itemCount: langCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                            color: getColourByNumber(index),
                            child: Padding(
                              padding: EdgeInsets.all(10.0 * toScale),
                              child: Text(
                                langCategories[index],
                                textAlign: TextAlign.center,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    color: getTextColourByNumber(index),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16 * toScale),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              UserPreferences.setLanguageSet(index);
                            });
                            Timer(const Duration(milliseconds: 500), () {
                              setState(() {
                                Navigator.pop(context, true);
                              });
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10 * toScale, 10 * toScale, 10 * toScale, 10 * toScale),
                    child: Text(
                      "To reduce interface clutter, you can choose to limit the "
                          "set of languages you want available in the language "
                          "selector. \n\n'Minimal' has only Quenya and Sindarin; "
                          "'basic' has the languages with the largest known "
                          "vocabularies; 'medium' and 'large' contain lesser-known "
                          "language, and 'complete' contains everything from "
                          "Eldamo.org.\n\n"
                          "The active language set is indicated with the same "
                          "colour as above, in the Eldarin language field and the "
                          "'form-gloss' switch in the search screen.\n\n"
                          "The choice is remembered by the app until you change it. "
                          "The down arrow (top right) cancels this screen.",
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
