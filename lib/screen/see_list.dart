import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';
import 'entry_screen.dart';

class SeeListItem extends StatefulWidget {
  const SeeListItem({
    Key? key,
    required this.entryId,
    required this.language,
    required this.form,
    required this.see,
    required this.seeId,
  }) : super(key: key);

  final int entryId;
  final String language;
  final String form;
  final String see;
  final int seeId;

  @override
  State<SeeListItem> createState() => _SeeListItemState();
}


Route _seeDetailRoute(int seeId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        EntryScreen(seeId),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _SeeListItemState extends State<SeeListItem> {

  String htmlData = "";

  void initState() {

    htmlData += (widget.see.contains('also') ? CSSTealText : (
        (widget.see.contains('further') ? CSSYellowText : (
            (widget.see.contains('notes') ? CSSPurpleText : CSSRedText))))) +
        widget.see + CloseSpan + "&nbsp;&nbsp;";

    if (widget.language.isNotEmpty) {
      htmlData += CSSBolder +
          widget.language.toUpperCase() +
          CloseSpan +
          "&nbsp;&nbsp;";
    }

    htmlData += CSSBoldVeryBlue +
        widget.form +
        CloseSpan;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(htmlData);
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).push(_seeDetailRoute(widget.seeId));
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
