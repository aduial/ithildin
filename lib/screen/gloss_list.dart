import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class GlossListItem extends StatefulWidget {
  const GlossListItem({
    Key? key,
    required this.entryId,
    required this.gloss,
    required this.reference,
  }) : super(key: key);

  final int entryId;
  final String gloss;
  final String reference;

  @override
  State<GlossListItem> createState() => _GlossListItemState();
}

class _GlossListItemState extends State<GlossListItem> {
  String htmlData = "";
  void initState() {
    htmlData += CSSGreenItalic + '"' + widget.gloss + '"' + CloseSpan +  "&nbsp;&nbsp;";
    htmlData += CSSText +  widget.reference + CloseSpan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
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
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // return Padding(
  //   //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //
  //   return Container(
  //     padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Flexible(
  //             fit: FlexFit.tight,
  //             flex: 1,
  //             child: RichText(
  //               text: TextSpan(
  //                 text: widget.gloss,
  //                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
  //                     fontWeight: FontWeight.w400,
  //                     fontSize: 12,
  //                     color: MiddleGreen),
  //                 children: <TextSpan>[
  //                   TextSpan(
  //                     text: widget.reference,
  //                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
  //                         fontWeight: FontWeight.w300,
  //                         fontSize: 12,
  //                         color: DarkGreen),
  //                   ),
  //                 ],
  //               ),
  //             )),
  //       ],
  //     ),
  //   );
  // }
}
