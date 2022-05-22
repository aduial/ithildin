import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/simplexicon.dart';
import 'entry_screen.dart';

class ChangeListItem extends StatefulWidget {
  const ChangeListItem({
    Key? key,
    required this.entryId,
    required this.markFrom,
    required this.formFrom,
    required this.markTo,
    required this.formTo,
    required this.sources,
    required this.idTo,
  }) : super(key: key);

  final int entryId;
  final String markFrom;
  final String formFrom;
  final String markTo;
  final String formTo;
  final String sources;
  final int idTo;

  @override
  State<ChangeListItem> createState() => _ChangeListItemState();
}

Route _changeDetailRoute(int idTo) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => EntryScreen(idTo),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _ChangeListItemState extends State<ChangeListItem> {
  String htmlData = "";

  void initState() {
    formatHtml();
    super.initState();
  }

  formatHtml() async {
    htmlData +=
        "${widget.markFrom.contains('-')
            ? CSSBoldDisabled
            : CSSBoldVeryBlue}${widget.formFrom}$CloseSpan&nbsp;&nbsp;➔&nbsp;&nbsp;";

    htmlData +=
        "${widget.markTo.contains('-')
            ? CSSBoldDisabled
            : CSSBoldVeryBlue}${widget.formTo}$CloseSpan&nbsp;&nbsp;";

    if (widget.sources.isNotEmpty) {
      htmlData += cssText + widget.sources + CloseSpan;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).push(_changeDetailRoute(widget.idTo));
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        color: NotepaperLinked,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Html(data: htmlData),
            ),
          ],
        ),
      ),
    );
  }
}
