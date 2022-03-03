import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class CognateListItem extends StatefulWidget {
  const CognateListItem({
    Key? key,
    required this.entryId,
    required this.language,
    required this.form,
    this.gloss,
    required this.sources,
  }) : super(key: key);

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String sources;

  @override
  State<CognateListItem> createState() => _CognateListItemState();
}

class _CognateListItemState extends State<CognateListItem> {

  String htmlData = "";
  void initState() {
    htmlData += CSSBolder + widget.language.toUpperCase() + CloseSpan + "&nbsp;&nbsp;";
    htmlData += CSSBoldBlueGrey +  widget.form + CloseSpan + "&nbsp;&nbsp;";
    if (widget.gloss != null && widget.gloss!.isNotEmpty){
      htmlData += CSSGreenItalic + '"' + (widget.gloss?? "") + '"' + CloseSpan + "&nbsp;&nbsp;";
    }
    htmlData += CSSText + widget.sources.replaceAll('.', '') + CloseSpan;
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
  //
  //   return Container(
  //     padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Flexible(
  //             fit: FlexFit.tight,
  //             flex: 1,
  //             child: RichText(
  //               text: TextSpan(
  //                 text: widget.language.toUpperCase(),
  //                 style: Theme.of(context)
  //                     .textTheme
  //                     .bodyText2!
  //                     .copyWith(fontWeight: FontWeight.w700),
  //                 children: <TextSpan>[
  //                   TextSpan(
  //                     text: widget.form,
  //                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
  //                         fontWeight: FontWeight.w800,
  //                         fontSize: 12,
  //                         color: BluerGrey),
  //                   ),
  //                   TextSpan(
  //                     text: widget.gloss,
  //                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
  //                         fontWeight: FontWeight.w300,
  //                         fontSize: 12,
  //                         color: BluerGrey),
  //                   ),
  //                   TextSpan(
  //                     text: widget.sources,
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
