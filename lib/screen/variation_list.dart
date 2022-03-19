import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class VariationListItem extends StatefulWidget {
  const VariationListItem({
    Key? key,
    required this.entryId,
    required this.mark,
    required this.lform,
    required this.typeId,
    required this.varsource,
  }) : super(key: key);

  final int entryId;
  final String mark;
  final String lform;
  final int typeId;
  final String varsource;

  @override
  State<VariationListItem> createState() => _VariationListItemState();
}

class _VariationListItemState extends State<VariationListItem> {

  String htmlData = "";

  void initState() {

    htmlData += (widget.mark.contains('-') ? CSSBoldDisabled : CSSBoldBlueGrey) +
        widget.lform + CloseSpan + "&nbsp;&nbsp;";
    htmlData += CSSText + widget.varsource + CloseSpan;

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
