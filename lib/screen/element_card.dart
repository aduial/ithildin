import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ithildin/model/lexicon_combine.dart';
import '../config/colours.dart';
import 'dart:math' as math;
import '../model/lexicon_element.dart';
import 'combination_list.dart';
import 'element_list.dart';

class ElementCard extends StatelessWidget {
  List<LexiconElement> lexiconElement;

  ElementCard(this.lexiconElement, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconElement.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ElementListItem(
                  entryId: lexiconElement[index].entryId,
                  formFrom: lexiconElement[index].formFrom,
                  glossFrom: lexiconElement[index].glossFrom,
                  inflection: lexiconElement[index].inflection,
                  idTo: lexiconElement[index].idTo,
                  formTo: lexiconElement[index].formTo,
                  glossTo: lexiconElement[index].glossTo,
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
                              child: lexiconElement.isEmpty
                                  ? Text("no elements found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                                  : Text(
                                  "element" +
                                      (lexiconElement.length > 1 ? "s" : ""),
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