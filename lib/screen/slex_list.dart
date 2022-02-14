import 'package:flutter/material.dart';
import 'package:ithildin/screen/entry_screen.dart';

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
    pageBuilder: (context, animation, secondaryAnimation) => EntryScreen(entryId),
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
          print('tapped on Entry:' + widget.id.toString());
          Navigator.of(context).push(_detailRoute(widget.id));
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade100),
          ),
          color: Colors.blueGrey.shade600,
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                widget.formLangAbbr,
                style: const TextStyle(
                  color: Colors.limeAccent,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                widget.mark,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Text(
                widget.form,
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Text(
                widget.gloss,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
