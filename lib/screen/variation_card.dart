import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/screen/variation_list.dart';
import '../config/colours.dart';
import '../model/lexicon_variation.dart';
import 'dart:math' as math;

class VariationCard extends StatelessWidget {
  List<LexiconVariation> lexiconVariations;

  VariationCard(this.lexiconVariations, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconVariations.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return VariationListItem(
                  entryId: lexiconVariations[index].entryId,
                  mark: lexiconVariations[index].mark,
                  form: lexiconVariations[index].form,
                  sources: lexiconVariations[index].sources,
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
                              child: lexiconVariations.isEmpty
                                  ? Text("no variations found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                                  : Text(
                                "variation" +
                                    (lexiconVariations.length > 1 ? "s" : ""),
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