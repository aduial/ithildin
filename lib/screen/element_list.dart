import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/simplexicon.dart';
import 'entry_screen.dart';

class ElementListItem extends StatefulWidget {
  const ElementListItem({
    Key? key,
    required this.entryId,
    required this.formFrom,
    this.glossFrom,
    required this.inflection,
    required this.idTo,
    required this.formTo,
    this.glossTo,
  }) : super(key: key);


  final int entryId;
  final String formFrom;
  final String? glossFrom;
  final String inflection;
  final int idTo;
  final String formTo;
  final String? glossTo;

  @override
  State<ElementListItem> createState() => _ElementListItemState();
}

Route _relatedDetailRoute(int relatedId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        EntryScreen(relatedId),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _ElementListItemState extends State<ElementListItem> {
  String htmlData = "";

  void initState() {
    formatHtml();
    super.initState();
  }

  formatHtml() async {

    htmlData += CSSBoldVeryBlue +
        widget.formFrom +
        CloseSpan +
        "&nbsp;&nbsp;";

    if (widget.glossFrom != null && widget.glossFrom!.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          (widget.glossFrom ?? "") +
          '"' +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    if (widget.inflection.isNotEmpty) {
      htmlData += CSSText +
          widget.inflection +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    htmlData += CSSBoldVeryBlue +
        widget.formTo +
        CloseSpan +
        "&nbsp;&nbsp;";

    if (widget.glossTo != null && widget.glossTo!.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          (widget.glossTo ?? "") +
          '"' +
          CloseSpan;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        if (widget.idTo != null) {
          setState(() {
            Navigator.of(context).push(_relatedDetailRoute(widget.idTo));
          });
        }
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
