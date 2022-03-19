import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/simplexicon.dart';
import 'entry_screen.dart';

class CognateListItem extends StatefulWidget {
  const CognateListItem({
    Key? key,
    required this.entryId,
    required this.language,
    required this.form,
    this.gloss,
    required this.sources,
    required this.cognateId,
  }) : super(key: key);

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String sources;
  final int cognateId;

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
  late bool hasEntry = false;
  late String htmlData = "";

  late List<Simplexicon> otherEntries;

  void initState() {
    checkForLinks();
    super.initState();
  }

  Future checkForLinks() async {
    hasEntry = await EldamoDb.instance
        .existsSimplexiconById(widget.cognateId);
    htmlData = await formatHtml();
  }

  Future<String> formatHtml() async {
    htmlData += CSSBolder +
        widget.language.toUpperCase() +
        CloseSpan +
        "&nbsp;&nbsp;";
    htmlData += (hasEntry ? CSSBoldVeryBlue : CSSBoldBlueGrey) +
        widget.form +
        CloseSpan +
        "&nbsp;&nbsp;";
    if (widget.gloss != null && widget.gloss!.isNotEmpty) {
      htmlData += CSSGreenItalic +
          '"' +
          (widget.gloss ?? "") +
          '"' +
          CloseSpan +
          "&nbsp;&nbsp;";
    }
    htmlData += CSSText + widget.sources.replaceAll('.', '') + CloseSpan;
    return htmlData;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasEntry) {
          setState(() {
            Navigator.of(context).push(_cognateDetailRoute(widget.cognateId));
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
