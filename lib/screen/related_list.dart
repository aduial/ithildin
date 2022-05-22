import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
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
    this.relatedId,
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
  final int? relatedId;

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
  String htmlData = "";

  void initState() {
    formatHtml();
    super.initState();
  }

  formatHtml() async {
    if (widget.languageFrom.isNotEmpty) {
      htmlData += CSSBolder +
          widget.languageFrom.toUpperCase() +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    htmlData += ((widget.relatedId != null && widget.formFrom.startsWith("@")) ? CSSBoldVeryBlue : cssBoldBlueGrey) +
        (widget.formFrom.startsWith("@") ? widget.formFrom.substring(1) : widget.formFrom) +
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
      htmlData += cssText +
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

    htmlData += ((widget.relatedId != null && widget.formTo.startsWith("@")) ? CSSBoldVeryBlue : cssBoldBlueGrey) +
        (widget.formTo.startsWith("@") ? widget.formTo.substring(1) : widget.formTo) +
        CloseSpan +
        "&nbsp;&nbsp;";

    if (widget.glossTo.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          widget.glossTo +
          '"' +
          CloseSpan;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        if (widget.relatedId != null) {
          setState(() {
            Navigator.of(context).push(_relatedDetailRoute(widget.relatedId!));
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),

        color: widget.relatedId != null ? NotepaperLinked : NotepaperWhite,
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
