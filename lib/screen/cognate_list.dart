import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import 'entry_screen.dart';

class CognateListItem extends StatefulWidget {
  const CognateListItem({
    Key? key,
    required this.entryId,
    required this.language,
    required this.form,
    this.gloss,
    required this.sources,
    this.cognateId,
  }) : super(key: key);

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String sources;
  final int? cognateId;

  @override
  State<CognateListItem> createState() => _CognateListItemState();
}

Route _cognateDetailRoute(int cognateId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        EntryScreen(cognateId),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _CognateListItemState extends State<CognateListItem> {
  String htmlData = "";

  void initState() {
    formatHtml();
    super.initState();
  }

  formatHtml() {
    htmlData += CSSBolder +
        widget.language.toUpperCase() +
        CloseSpan +
        "&nbsp;&nbsp;";
    htmlData += (widget.cognateId != null ? CSSBoldVeryBlue : CSSBoldBlueGrey) +
        widget.form +
        CloseSpan +
        "&nbsp;&nbsp;";
    if (widget.gloss != null && widget.gloss!.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          (widget.gloss ?? "") +
          '"' +
          CloseSpan;
    }
    htmlData += CSSText + widget.sources.replaceAll('.', '') + CloseSpan;
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        if (widget.cognateId != null) {
          setState(() {
            Navigator.of(context).push(_cognateDetailRoute(widget.cognateId!));
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        color: widget.cognateId != null ? NotepaperLinked : NotepaperWhite,
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
