import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class VariationListItem extends StatefulWidget {
  const VariationListItem({
    Key? key,
    required this.entryId,
    required this.mark,
    required this.form,
    required this.sources,
  }) : super(key: key);

  final int entryId;
  final String mark;
  final String form;
  final String sources;

  @override
  State<VariationListItem> createState() => _VariationListItemState();
}

class _VariationListItemState extends State<VariationListItem> {

  String htmlData = "";

  void initState() {

    htmlData += (widget.mark.contains('-') ? CSSBoldDisabled : CSSBoldBlueGrey) +
        widget.form + CloseSpan + "&nbsp;&nbsp;";
    htmlData += CSSText + widget.sources + CloseSpan;

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
