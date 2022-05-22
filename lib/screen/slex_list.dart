import 'package:flutter/material.dart';
import 'package:ithildin/screen/entry_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../config/colours.dart';
import '../config/config.dart';

class SLexListItem extends StatefulWidget {
  const SLexListItem({
    Key? key,
    required this.id,
    required this.formLangAbbr,
    required this.mark,
    required this.form,
    required this.gloss,
    required this.isRoot,
  }) : super(key: key);

  final int id;
  final String formLangAbbr;
  final String mark;
  final String form;
  final String gloss;
  final bool isRoot;

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

    double toScale = (MediaQuery.of(context).size.width / refWidth);

    Color getFormColour(String mark, bool isRoot){
      if (mark.contains("|")) {
        return StruckOutFormColour;
      } else if (isRoot) {
        return RootColour;
      } else if (mark.contains("!")) {
        return NeoFormColour;
      } else if (mark.contains("‽")) {
        return QuestionedFormColour;
      } else if (mark.contains("?")) {
        return SpeculativeFormColour;
      } else if (mark.contains("^")) {
        return ReformulatedFormColour;
      } else if (mark.contains("*")) {
        return ReconstructedFormColour;
      } else if (mark.contains("#")) {
        return DerivedFormColour;
      } else {
        return RegularFormColour;
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).push(_detailRoute(widget.id));
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0 * toScale, 2.0 * toScale, 5.0 * toScale, 2.0 * toScale),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: toScale, color: Colors.lightBlue.shade100),
          ),
          color: widget.mark.contains("†") ? PoeticResultBGColour : RegularResultBGColour,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Text(
                  widget.formLangAbbr,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Telperion,
                      fontSize: 16 * toScale,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4 * toScale, 0),
                child: Text(
                  widget.mark.replaceAll("|", "").replaceAll("-", ""),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: getFormColour(widget.mark, widget.isRoot),
                      fontSize: 14 * toScale,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              flex: 16,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 6 * toScale, 0),
                child: AutoSizeText(
                  widget.form,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: getFormColour(widget.mark, widget.isRoot),
                      fontSize: 16 * toScale,
                      fontWeight: FontWeight.w500),
                  minFontSize: 12,
                  stepGranularity: 4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 24,
              child: AutoSizeText(
                widget.gloss,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontSize: 16 * toScale,
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
