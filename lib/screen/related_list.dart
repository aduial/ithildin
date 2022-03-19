import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/simplexicon.dart';
import 'entry_screen.dart';

class RelatedListItem extends StatefulWidget {
  const RelatedListItem({
    Key? key,
    required this.entryId,
    required this.languageFrom,
    required this.formFrom,
    required this.glossFrom,
    required this.relation,
    required this.languageTo,
    required this.formTo,
    required this.glossTo,
    required this.refSources,
    required this.relatedId,
  }) : super(key: key);

  final int entryId;
  final String languageFrom;
  final String formFrom;
  final String glossFrom;
  final String relation;
  final String languageTo;
  final String formTo;
  final String glossTo;
  final String refSources;
  final int relatedId;

  @override
  State<RelatedListItem> createState() => _RelatedListItemState();
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

class _RelatedListItemState extends State<RelatedListItem> {
  late bool hasEntry = false;
  late String htmlData = "";

  late List<Simplexicon> otherEntries;

  void initState() {
    checkForLinks();
    super.initState();
  }

  Future checkForLinks() async {
    hasEntry = await EldamoDb.instance.existsSimplexiconById(widget.relatedId);
    htmlData = await formatHtml();
  }

  Future<String> formatHtml() async {
    if (widget.languageFrom.isNotEmpty) {
      htmlData += CSSBolder +
          widget.languageFrom.toUpperCase() +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    htmlData += (hasEntry && widget.formFrom.startsWith("@") ? CSSBoldVeryBlue : CSSBoldBlueGrey) +
        widget.formFrom.substring(1) +
        CloseSpan +
        "&nbsp;&nbsp;";

    if (widget.glossFrom.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          widget.glossFrom +
          '"' +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    if (widget.relation.isNotEmpty) {
      htmlData += CSSText +
          widget.relation +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    if (widget.languageTo.isNotEmpty) {
      htmlData += CSSBolder +
          widget.languageTo.toUpperCase() +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    htmlData += (hasEntry && widget.formTo.startsWith("@") ? CSSBoldVeryBlue : CSSBoldBlueGrey) +
        widget.formTo.substring(1) +
        CloseSpan +
        "&nbsp;&nbsp;";

    if (widget.glossTo.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          widget.glossTo +
          '"' +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    if (widget.refSources.isNotEmpty) {
      htmlData += CSSBoldGreen + widget.glossTo + CloseSpan;
    }
    return htmlData;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasEntry) {
          setState(() {
            Navigator.of(context).push(_relatedDetailRoute(widget.relatedId));
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),

        color: hasEntry ? NotepaperLinked : NotepaperWhite,
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
