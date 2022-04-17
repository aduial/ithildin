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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: RegularResultBGColour,
        title: Text("choose language set"),
        actions: <Widget>[
            IconButton(
              icon: const Icon(
                  CupertinoIcons.arrowtriangle_down_square,
                  color: BrightGreen),
              onPressed: () => Navigator.pop(context, false),
              tooltip: 'cancel',
            )
        ],
      ),
      backgroundColor: BlueGrey,
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),

                    child: ListView.builder(
                      itemCount: langCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                            color: getColourByNumber(index),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                langCategories[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: DarkerBlueGrey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          onTap: () {
                            UserPreferences.setLanguageSet(index);
                            Navigator.pop(context, true);
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
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Text(
                      "Usage: tap the (?) icon top right in the next screen",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Ithildin,
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
    );
  }
}
