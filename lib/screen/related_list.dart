import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class RelatedListItem extends StatefulWidget {
  const RelatedListItem({
    Key? key,
    required this.entryId,
    this.formFrom,
    this.glossFrom,
    this.relation,
    this.formTo,
    this.glossTo,
  }) : super(key: key);

  final int entryId;
  final String? formFrom;
  final String? glossFrom;
  final String? relation;
  final String? formTo;
  final String? glossTo;

  @override
  State<RelatedListItem> createState() => _RelatedListItemState();
}

class _RelatedListItemState extends State<RelatedListItem> {

  String htmlData = "";

  void initState() {
    if (widget.formFrom != null){
      htmlData += CSSBoldBlueGrey + (widget.formFrom?? "") + CloseSpan + "&nbsp;&nbsp;";
    }
    if (widget.glossFrom != null && widget.glossFrom!.isNotEmpty){
      htmlData += CSSGreenItalic + '"' + (widget.glossFrom?? "") + '"' + CloseSpan + "&nbsp;&nbsp;";
    }
    if (widget.relation != null){
      htmlData += CSSText + (widget.relation?? "") + CloseSpan + "&nbsp;&nbsp;";
    }
    if (widget.formTo != null){
      htmlData += CSSBlueGreyItalic + (widget.formTo?? "") + CloseSpan + "&nbsp;&nbsp;";
    }
    if (widget.glossTo != null){
      htmlData += CSSBoldGreen + (widget.glossTo?? "") + CloseSpan;
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
