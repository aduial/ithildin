import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../config/colours.dart';
import '../model/lexicon_inflection.dart';
import 'dart:math' as math;

import 'inflection_list.dart';

class InflectionCard extends StatelessWidget {
  List<LexiconInflection> lexiconInflections;

  InflectionCard(this.lexiconInflections, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconInflections.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InflectionListItem(
                  entryId: lexiconInflections[index].entryId,
                  mark: lexiconInflections[index].mark,
                  form: lexiconInflections[index].form,
                  inflections: lexiconInflections[index].inflections,
                  gloss: lexiconInflections[index].gloss,
                  references: lexiconInflections[index].references,
                );
              }));
    }

    return ExpandableNotifier(
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
                              child: lexiconInflections.isEmpty
                                  ? Text("no inflections found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                                  : Text(
                                "inflection" +
                                    (lexiconInflections.length > 1
                                        ? "s"
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