import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class ExampleListItem extends StatefulWidget {
  const ExampleListItem({
    Key? key,
    required this.entryId,
    required this.form,
    required this.source,
  }) : super(key: key);

  final int entryId;
  final String form;
  final String source;

  @override
  State<ExampleListItem> createState() => _ExampleListItemState();
}

class _ExampleListItemState extends State<ExampleListItem> {
  String htmlData = "";

  void initState() {

    htmlData += CSSBoldVeryBlue +
        widget.form +
        CloseSpan +
        "&nbsp;&nbsp;";

    htmlData += cssText +  widget.source + CloseSpan;

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
