import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/screen/related_list.dart';
import '../config/colours.dart';
import '../model/lexicon_related.dart';
import 'dart:math' as math;

class RelatedCard extends StatelessWidget {
  List<LexiconRelated> lexiconRelated;

  RelatedCard(this.lexiconRelated, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconRelated.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RelatedListItem(
                  entryId: lexiconRelated[index].entryId,
                  languageFrom: lexiconRelated[index].languageFrom,
                  formFrom: lexiconRelated[index].formFrom,
                  glossFrom: lexiconRelated[index].glossFrom,
                  relation: lexiconRelated[index].relation,
                  languageTo: lexiconRelated[index].languageTo,
                  formTo: lexiconRelated[index].formTo,
                  glossTo: lexiconRelated[index].glossTo,
                  refSources: lexiconRelated[index].refSources,
                  relatedId: lexiconRelated[index].relatedId,
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
                              child: lexiconRelated.isEmpty
                                  ? Text("no related words found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                                  : Text(
                                  "related word" +
                                      (lexiconRelated.length > 1 ? "s" : ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin)),
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