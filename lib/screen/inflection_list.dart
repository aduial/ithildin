import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class InflectionListItem extends StatefulWidget {
  const InflectionListItem({
    Key? key,
    required this.entryId,
    required this.mark,
    required this.form,
    required this.inflections,
    this.gloss,
    this.references,
  }) : super(key: key);


  final int entryId;
  final String mark;
  final String form;
  final String inflections;
  final String? gloss;
  final String? references;

  @override
  State<InflectionListItem> createState() => _InflectionListItemState();
}

class _InflectionListItemState extends State<InflectionListItem> {

  String htmlData = "";

  void initState() {

    htmlData += (widget.mark.contains('-') ? CSSBoldDisabled : CSSBoldBlueGrey) +
        widget.form + CloseSpan + "&nbsp;&nbsp;";

    htmlData += CSSBolder + widget.inflections + CloseSpan + "&nbsp;&nbsp;";

    if (widget.gloss != null && widget.gloss!.isNotEmpty){
      htmlData += CSSGreenItalic + '"' + (widget.gloss?? "") + '"' + CloseSpan + "&nbsp;&nbsp;";
    }
    if (widget.references != null) {
      htmlData += CSSText + (widget.references?? "") + CloseSpan;
    }

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
}
