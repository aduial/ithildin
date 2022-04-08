import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import '../model/entry_doc.dart';
import 'dart:math' as math;
import 'package:html/dom.dart' as dom; // that is

class NoteCard extends StatelessWidget {
  List<EntryDoc> entryDoc;
  final ValueChanged<String> parentAction;

  NoteCard(this.entryDoc, this.parentAction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildNote() {
      if (entryDoc.isEmpty) {
        return Container();
      } else {
        return Container(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          color: NotepaperWhite,
          child: Html(
            data: entryDoc[0].doc ?? '',
            style: {
              "body": Style(
                fontSize: FontSize(15.0),
                color: ThemeTextColour,
              ),
            },
            onLinkTap: (
                String? url,
                RenderContext context,
                Map<String, String> attributes,
                dom.Element? element,
                ) {
              //setState(() {
              parentAction(url ?? '');
            },
          ),
        );
      }
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
                              child: entryDoc.isEmpty
                                  ? Text(
                                "no notes found",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: LightBlueGrey),
                              )
                                  : Text(
                                "notes",
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
                    expanded: buildNote(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}