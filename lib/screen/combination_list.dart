import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import 'entry_screen.dart';

class CombinationListItem extends StatefulWidget {
  const CombinationListItem({
    Key? key,
    required this.entryId,
    required this.formFrom,
    required this.langFrom,
    required this.idTo,
    required this.formTo,
    required this.langTo,
  }) : super(key: key);

  final int entryId;
  final String formFrom;
  final String langFrom;
  final int idTo;
  final String formTo;
  final String langTo;

  @override
  State<CombinationListItem> createState() => _CombinationListItemState();
}

Route _combinationDetailRoute(int idTo) {
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

class _CombinationListItemState extends State<CombinationListItem> {
  String htmlData = "";

  void initState() {
    formatHtml();
    super.initState();
  }

  formatHtml() async {
    if (widget.langFrom.isNotEmpty) {
      htmlData +=
          "$CSSBolder${widget.langFrom.toUpperCase()}$CloseSpan&nbsp;&nbsp;";
    }

    htmlData += "$CSSBoldVeryBlue${widget.formFrom}$CloseSpan&nbsp;&nbsp;";

    if (widget.langTo.isNotEmpty) {
      htmlData +=
          "$CSSBolder${widget.langTo.toUpperCase()}$CloseSpan&nbsp;&nbsp;";
    }

    htmlData += CSSBoldVeryBlue + widget.formTo + CloseSpan;
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).push(_combinationDetailRoute(widget.idTo));
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
