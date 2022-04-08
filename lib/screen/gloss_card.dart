import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../config/colours.dart';
import '../model/lexicon_gloss.dart';
import 'gloss_list.dart';
import 'dart:math' as math;

class GlossCard extends StatelessWidget {
  List<LexiconGloss> lexiconGlosses;

  GlossCard(this.lexiconGlosses, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconGlosses.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GlossListItem(
                  entryId: lexiconGlosses[index].entryId,
                  gloss: lexiconGlosses[index].gloss,
                  sources: lexiconGlosses[index].sources,
                );
              }));
    }

    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: BlueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                // fadeCurve: Curves.decelerate,
                                // animationDuration: const Duration(milliseconds: 400),
                                // scrollAnimationDuration: const Duration(milliseconds: 400),
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: lexiconGlosses.isEmpty
                                  ? Text("no glosses found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                                  : Text(
                                "gloss" +
                                    (lexiconGlosses.length > 1
                                        ? "es"
                                        : ""),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Laurelin),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    collapsed: Container(),
                    expanded: buildList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}