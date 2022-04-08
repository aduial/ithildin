import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/model/lexicon_combine.dart';
import '../config/colours.dart';
import 'dart:math' as math;
import 'combination_list.dart';

class CombinationCard extends StatelessWidget {
  List<LexiconCombine> lexiconCombination;

  CombinationCard(this.lexiconCombination, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconCombination.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CombinationListItem(
                  entryId: lexiconCombination[index].entryId,
                  formFrom: lexiconCombination[index].formFrom,
                  langFrom: lexiconCombination[index].langFrom,
                  idTo: lexiconCombination[index].idTo,
                  formTo: lexiconCombination[index].formTo,
                  langTo: lexiconCombination[index].langTo,
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
                              child: lexiconCombination.isEmpty
                                  ? Text("no combinations found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                                  : Text(
                                  "combination" +
                                      (lexiconCombination.length > 1 ? "s" : ""),
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