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
    required this.language,
    required this.form,
    this.gloss,
    this.inflections,
    this.sources,
    required this.elementId,
  }) : super(key: key);

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String? inflections;
  final String? sources;
  final int elementId;

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
    if (widget.language != "") {
      htmlData += CSSBolder +
          '"' +
          widget.language.toUpperCase() +
          '"' +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    htmlData += "$cssBoldBlueGrey${widget.form}$CloseSpan&nbsp;&nbsp;";

    if (widget.gloss != null && widget.gloss!.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          (widget.gloss ?? "") +
          '"' +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    if (widget.inflections != null && widget.inflections!.isNotEmpty) {
      htmlData += "$CSSBolder${widget.inflections ?? ""}$CloseSpan&nbsp;&nbsp;";
    }

    if (widget.sources != null && widget.sources!.isNotEmpty) {
      htmlData += cssText +
          (widget.sources ?? "") +
          CloseSpan;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).push(_relatedDetailRoute(widget.elementId));
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
