import 'package:flutter/material.dart';
import 'package:ithildin/screen/entry_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../config/colours.dart';

class SLexListItem extends StatefulWidget {
  const SLexListItem({
    Key? key,
    required this.id,
    required this.formLangAbbr,
    required this.mark,
    required this.form,
    required this.gloss,
  }) : super(key: key);

  final int id;
  final String formLangAbbr;
  final String mark;
  final String form;
  final String gloss;

  @override
  State<SLexListItem> createState() => _SLexListItemState();
// _SLexListItemState createState() => _SLexListItemState();
}

Route _detailRoute(int entryId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        EntryScreen(entryId),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _SLexListItemState extends State<SLexListItem> {
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 5.0),

    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).push(_detailRoute(widget.id));
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade100),
          ),
          color: DarkBlueGrey,//Colors.blueGrey.shade600,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Text(
                  widget.formLangAbbr,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Telperion,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                child: Text(
                  widget.mark,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: BrightGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                child: AutoSizeText(
                  widget.form,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: LightBlueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  minFontSize: 12,
                  stepGranularity: 4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: AutoSizeText(
                widget.gloss,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
                minFontSize: 12,
                stepGranularity: 4,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
